//
//  RightSideMenuVC.swift
//  modes-mobile-ios
//
//  Created by Neal Gentry on 9/8/20.
//

import Foundation
import UIKit

class RightSMTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Here you can customize the appearance of your cell
    override func layoutSubviews() {
        super.layoutSubviews()
        // Customize imageView like you need
        //self.imageView?.frame = CGRect(x: 0,y: 0,width: 40,height: 40)
        //self.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        // Costomize other elements
        self.textLabel?.frame = CGRect(x: 30, y: 10, width: self.frame.width - 45, height: 20)
        self.imageView?.frame = CGRect(x: 2, y: 8, width: 4, height: 24)
        self.accessoryView?.frame = CGRect(x:30, y:16, width: 280, height: 1)
    }
}



class RightSideMenuVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var viewforTable: UIView!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var lblVersion: UILabel!
    
    @IBOutlet weak var viewforRightVertTwoCol: Right_VertTwoCollView!
    //Array of Page Titles
    let titles: [String] = ["My Military OneSource", "MilLife Guides", "Benefits Finder", "Favorites", "Connect", "", "About My Military OneSource", "Settings", "Feedback", "", "Military OneSource Network"]
    
    
    var customView = UIView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        let titleSize = titles.count
        
     
        tableView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isOpaque = false
        //tableView.backgroundColor = UIColor.green
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.bounces = false
        return tableView
        }()
    
    @IBAction func btnCloseTouched(_ sender: Any) {
        sideMenuViewController?.hideMenuViewController()
    }
    
    func presentExternalAlert(myURL: URL){
        let storyboard = UIStoryboard(name: "ExternalAlert", bundle: nil)
        let externalAlert = storyboard.instantiateViewController(withIdentifier: "externalalert_sbid") as! ExternalAlertView
        externalAlert.providesPresentationContextTransitionStyle = true
        externalAlert.definesPresentationContext = true
        externalAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        externalAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        externalAlert.delegate = self
        externalAlert.myURL = myURL
        self.present(externalAlert, animated: true, completion: nil)
    }
    
    //Social Media Buttons
    
    @IBAction func btnFaceBookTouched(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/military.1source") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
                
            }
        }
    }
    
    @IBAction func btnTwitterTouched(_ sender: Any) {
        if let url = URL(string: "https://twitter.com/military1source") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
    }
    
    @IBAction func btnYouTubeTouched(_ sender: Any) {
        if let url = URL(string: "https://www.youtube.com/user/Military1Source") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
    }
    
    @IBAction func btnPinterestTouched(_ sender: Any) {
        if let url = URL(string: "https://www.pinterest.com/military1source/") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
    }
    
    @IBAction func btnInstagramTouched(_ sender: Any) {
        if let url = URL(string: "https://www.instagram.com/military1source/") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIAccessibility.post(notification: .screenChanged, argument: self.btnClose)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        if let tabBarController = self.sideMenuViewController!.contentViewController as? UITabBarController {
                let aboutVC = AboutVC()
                tabBarController.viewControllers?.insert(aboutVC, at: 5)
        }
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 5
       
        viewforTable.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: viewforTable.frame.size.width, height: viewforTable.frame.size.height)
        
        let app = UIApplication.shared.delegate as! AppDelegate
        
        do {
            if let currentVersion = try app.getCurrentAppVersion() {
                lblVersion.text = "version " + currentVersion
            }
        } catch {
            print("Error trying to determine if app update is needed")
            lblVersion.text = ""
        }
        
        
   
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


// MARK : TableViewDataSource & Delegate Methods

extension RightSideMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ( indexPath.row == 5 || indexPath.row == 9 ) {
          return 20
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RightSMTableViewCell = RightSMTableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
    
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "WorkSans-Regular", size: 14)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text  = titles[indexPath.row]
        cell.selectionStyle = .none
        
        //Bold the needed Labels
        if (cell.textLabel?.text == "My Military OneSource" ||
            cell.textLabel?.text == "About My Military OneSource" ||
            cell.textLabel?.text == "Settings" ||
            cell.textLabel?.text == "Feedback" ||
            cell.textLabel?.text == "Military OneSource Network" )
            {
             cell.textLabel?.font = UIFont(name: "WorkSans-Bold", size: 14)
        }
        
        cell.imageView?.image = UIImage(named: "menu_clear_indicator")
        //TODO: Setup for Navigation Indicator
        //cell.imageView?.image = UIImage(named: "menu_red_indicator")
        
        if indexPath.row == 10 {
            cell.imageView?.image = UIImage(named: "menu_clear_indicator")
        }
        
        // accessibility
        cell.accessibilityLabel = cell.textLabel?.text
        cell.accessibilityTraits = UIAccessibilityTraits.button
        //cell.textLabel?.accessibilityLabel = cell.textLabel?.text
        //cell.textLabel?.accessibilityTraits = UIAccessibilityTraits.button
        
        //Setup for Dividers
        if cell.textLabel?.text == "" {
            cell.imageView?.image = UIImage(named: "menu_clear_indicator")
            cell.accessoryView = UIImageView(image: UIImage(named: "menu_divider"))
            cell.accessibilityElementsHidden = true
        }
            
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
        
        //Clear Back on Guides and Benefits Details
        let app = UIApplication.shared.delegate as! AppDelegate
        app.mainViewController?.clearNavFlags()
        
        if ( indexPath.row == 5 || indexPath.row == 9 || indexPath.row == 10 ) {
          return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Handle Feedback web link
        if ( indexPath.row == 8 ) {
            /*
            if let url = URL(string: "https://survey.foresee.com/f/M40JDlKiHK") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            */
            FirebaseUtility.shared.menuItemSelected(menuItem: "feedback")
            let storyboard = UIStoryboard(name: "InAppBrowser", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "InAppBrowserVC") as! InAppBrowserVC
            vc.delegate = self
            vc.fromRightSideMenu = true

            vc.urlString = "https://preview-survey.foresee.com/f/M40JDlKiHK?ok=false"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated:true, completion:nil)
            //sideMenuViewController?.hideMenuViewController()
            
          return
        }
        
        //Handle the About/Settings
        if (indexPath.row == 6) {
            FirebaseUtility.shared.menuItemSelected(menuItem: "about")
            let storyboard = UIStoryboard(name: "About", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
            vc.delegate = self
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
            //sideMenuViewController?.hideMenuViewController()
            return
        }
        
        if (indexPath.row == 7) {
            FirebaseUtility.shared.menuItemSelected(menuItem: "settings")
            let storyboard = UIStoryboard(name: "Settings", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            vc.delegate = self
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            //sideMenuViewController?.hideMenuViewController()
            return
        }
        
        
        
        if let tabBarController = self.sideMenuViewController!.contentViewController as? UITabBarController {
            tabBarController.selectedIndex = indexPath.row
            sideMenuViewController?.hideMenuViewController()
        }
        
        
        
        
    }
 
    
}


//Extension for Adding Return Protocol for Here
extension RightSideMenuVC: returntoPreviousProtocol {
    func rtPM_GoUserSettings() {
        FirebaseUtility.shared.menuItemSelected(menuItem: "settings")
        print("Back on Right Side Menu, in returntoPreviousProtocol - rtPM_GoUserSettings")
        let seconds = 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            let storyboard = UIStoryboard(name: "UserSettings", bundle: nil);
            let vc = storyboard.instantiateViewController(withIdentifier: "UserSettingsViewController") as! UserSettingsViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil);
        }
        
    }
    
    func rtPM_GoHome() {
        FirebaseUtility.shared.menuItemSelected(menuItem: "home")
        print("Back on Right Side Menu, in returntoPreviousProtocol - rtPM_GoHome")
        let seconds = 0.01
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.sideMenuViewController?.hideMenuViewController()
            if let tabBarController = self.sideMenuViewController!.contentViewController as? UITabBarController {
                tabBarController.selectedIndex = 0
            }
        }
    }

}


extension RightSideMenuVC: ExternalAlertViewDelegate {
    
    func okButtonTapped(urltovisit: URL) {
        print("okButtonTapped with \(urltovisit) ")
        UIApplication.shared.open(urltovisit, options: [:])
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }
}
