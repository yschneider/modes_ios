//
//  DBUpdater.swift
//  modes-mobile-ios
//
//  Created by yada on 11/5/20.
//

import Foundation

class FileUpdater{
    
    let newDBPath = "https://mos-file-storage.s3-us-gov-west-1.amazonaws.com/MyMilitaryOneSource/database/modes-2.sqlite3"
    let rootPath = "https://mos-file-storage.s3-us-gov-west-1.amazonaws.com/MyMilitaryOneSource/"
    
    func copyNewDB()->Bool{
        
        
        
        //first thing get the favorites
        
        let guidesFavorite = ModesDb.shared.getGuidesFavorites()
        let benefitsFavorite = ModesDb.shared.getBenefitsFavorites()

        
        var guidesFavoriteList = [FavoriteItem]()

        for favorite in guidesFavorite{
            let item = FavoriteItem()
            item.ID = favorite["ID"] as! Int
            item.name = favorite["Guide"] as? String
            item.type = "GUIDE"
            guidesFavoriteList.append(item)
        }
        
        
        var benefitFavoriteList = [FavoriteItem]()

        for favorite in benefitsFavorite{
            let item = FavoriteItem()
            item.ID = favorite["ID"] as! Int
            item.name = favorite["Benefit"] as? String
            item.type = "BENEFIT"
            benefitFavoriteList.append(item)
        }
        
        
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destURL = documentsURL!.appendingPathComponent("modes-new").appendingPathExtension("sqlite3")
        let dbUrl = documentsURL!.appendingPathComponent("modes").appendingPathExtension("sqlite3")
        
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: newDBPath)

        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)

        let request = URLRequest(url:fileURL!)

        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
               if let tempLocalUrl = tempLocalUrl, error == nil {
                   // Success
                   if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                       print("Successfully downloaded. Status code: \(statusCode)")
                   }
                   
                   do {
                        if FileManager.default.fileExists(atPath: dbUrl.path) {
                            try FileManager.default.removeItem(at: dbUrl)
                        }
                       try FileManager.default.copyItem(at: tempLocalUrl, to: dbUrl)
                    
                    SQLiteDB.shared.closeDB()
                    for favorite in guidesFavoriteList{
                        
                        ModesDb.shared.setGuidesFavorite(favorite: true, id: favorite.ID ?? 0)
                    }
                    for favorite in benefitFavoriteList{
                        ModesDb.shared.setBenefitsFavorite(favorite: true, id: favorite.ID ?? 0)
                    }
                    
                   } catch (let writeError) {
                       print("Error creating a file \(destURL) : \(writeError)")

                   }
                   
               } else {
                   print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
                   
               }
            }
        task.resume()
        
        return true
    }

    
    func copyFile(folder: String, fileName: String )->Bool{
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagesPath = documentsURL!.appendingPathComponent(folder)
        
        // create the folder if it not there
        do
        {
            try FileManager.default.createDirectory(atPath: imagesPath.path, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error as NSError
        {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
        
       
        let destURL = imagesPath.appendingPathComponent(fileName)
        
        
        //Create URL to the source file you want to download
        let fileStr = rootPath + folder + "/" + fileName
        print(fileStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        let newStr = fileStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        let fileURL = NSURL(string: newStr)
        
        if(fileURL == nil){
            print("bad")
        }

        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)

        let request = URLRequest(url:fileURL! as URL)

        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            
                /*
                if let resPath = Bundle.main.resourcePath {
                do {
                    let dirContents = try FileManager.default.contentsOfDirectory(atPath: resPath)
                    let filteredFiles = dirContents.filter{ $0.contains(fileExtension)}
                    for fileName in filteredFiles {
                        if let documentsURL = documentsURL {
                            let sourceURL = Bundle.main.bundleURL.appendingPathComponent(fileName)
                            
                            do { try FileManager.default.copyItem(at: sourceURL, to: destURL) } catch { }
                        }
                    }
                } catch { }
                */
            
            
            
               if let tempLocalUrl = tempLocalUrl, error == nil {
                   // Success
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                       print("Successfully downloaded. Status code: \(statusCode)")
                   }
                   
                   do {
                       try FileManager.default.copyItem(at: tempLocalUrl, to: destURL)
                   } catch (let writeError) {
                       print("Error creating a file \(destURL) : \(writeError)")

                   }
                   
               } else {
                   print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
                   
               }
            }
        task.resume()
        
        return true
    }
    
    
}
