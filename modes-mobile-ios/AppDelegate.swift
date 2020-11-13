//
//  AppDelegate.swift
//  modes-mobile-ios
//
//  Created by yada on 8/13/20.
//

import UIKit
import Firebase
import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RemoteSettingsDelegate {

    //added to change System font to WorkSans
    override init() {
           super.init()
           UIFont.overrideInitialize()
    }
    
    var mainViewController : MainTabViewController?

    var window: UIWindow?
    var navigationController: UINavigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 1)
        // Override point for customization after application launch.
        
        // set the url base
        //BASE_URL = STAGING_BASE_URL
        BASE_URL = PROD_BASE_URL
        
        copyFilesFromBundleToDocumentsFolderWith(folder: "small-images", fileExtension: "200x200.jpg")
        copyFilesFromBundleToDocumentsFolderWith(folder: "images-large", fileExtension: "1000x500.jpg")
        copyDbFromBundleIfNeeded()
        
        // start getting remote settings
        let remoteSettingsService = RemoteSettingsService()
        remoteSettingsService.remoteSettingsDelegate = self
        remoteSettingsService.getRemoteSettings()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Base", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()
        
        Analytics.setUserProperty("release", forName: "buildType")
        
        // face book set up
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return true
    }
    
    func remoteSettingsReceived(_ remoteSettings: RemoteSettings?) {
        if let settings = remoteSettings {
            do {
                if let currentVersion = try self.getCurrentAppVersion() {
                    // if remote version is greater than this app version...
                    if(settings.appUpdateSettings.version.compare(currentVersion, options: .numeric) == .orderedDescending) {
                        DispatchQueue.main.async {
                            self.showAppUpdateViewController(appUpdateSettings: settings.appUpdateSettings)
                        }
                    }
                    
                    else{
                        // we dont need an app update check for db update
                        
                        let dbVersion = ModesDb.shared.getDbVersion()
                        if(dbVersion != (remoteSettings?.appUpdateSettings.database.version)!){
                            print("db update needed")
                            
                            let fileUpdater = FileUpdater()
                            fileUpdater.copyNewDB()
                            
                            for file in settings.appUpdateSettings.database.largeFiles{
                                
                                fileUpdater.copyFile(folder: "images-large", fileName: file)
                            }
                            
                            for file in settings.appUpdateSettings.database.smallFiles{
                                fileUpdater.copyFile(folder: "small-images", fileName: file)
                            }
                        }
                        else{
                            print("db is current")
                        }
                    }
                }
                
                
                
            } catch {
                print("Error trying to determine if app update is needed")
            }
        }
    }
    
    func showAppUpdateViewController(appUpdateSettings: AppUpdateSettings?) {
        let storyboard = UIStoryboard(name: "RemoteSettings", bundle: nil)
        let appUpdateViewController = storyboard.instantiateViewController(withIdentifier: "AppUpdateViewController") as! AppUpdateViewController
        appUpdateViewController.appUpdateSettings = appUpdateSettings
        appUpdateViewController.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(appUpdateViewController, animated: true, completion: nil)
    }
    
    func getCurrentAppVersion() throws -> String? {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String else {
                throw VersionError.invalidBundleInfo
        }
        print(currentVersion)
        return currentVersion
    }
    
    enum VersionError: Error {
        case invalidBundleInfo
    }

    func copyDbFromBundleIfNeeded(){
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destURL = documentsURL!.appendingPathComponent("modes").appendingPathExtension("sqlite3")
        guard let sourceURL = Bundle.main.url(forResource: "modes", withExtension: "sqlite3")
            else {
                print("Source File not found.")
                return
        }
        
        let fileManager = FileManager.default
        do {
            if(!destURL.checkFileExist()){
                try fileManager.copyItem(at: sourceURL, to: destURL)
            }
        } catch {
            print("Unable to copy file")
        }
    }
    
    func copyFilesFromBundleToDocumentsFolderWith(folder: String, fileExtension: String) {
        if let resPath = Bundle.main.resourcePath {
            do {
                let dirContents = try FileManager.default.contentsOfDirectory(atPath: resPath)
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                
                let fileManager = FileManager.default
                

                let imagesPath = documentsURL!.appendingPathComponent(folder)
                do
                {
                    try FileManager.default.createDirectory(atPath: imagesPath.path, withIntermediateDirectories: true, attributes: nil)
                }
                catch let error as NSError
                {
                    NSLog("Unable to create directory \(error.debugDescription)")
                }
                
                
                let filteredFiles = dirContents.filter{ $0.contains(fileExtension)}
                for fileName in filteredFiles {
                    if let documentsURL = documentsURL {
                        let sourceURL = Bundle.main.bundleURL.appendingPathComponent(fileName)
                        let destURL = documentsURL.appendingPathComponent(folder + "/" + fileName)
                        do { try FileManager.default.copyItem(at: sourceURL, to: destURL) } catch { }
                    }
                }
            } catch { }
        }
    }
}

extension URL    {
    func checkFileExist() -> Bool {
        let path = self.path
        if (FileManager.default.fileExists(atPath: path))   {
            print("FILE AVAILABLE")
            return true
        }else        {
            print("FILE NOT AVAILABLE")
            return false;
        }
    }
}

