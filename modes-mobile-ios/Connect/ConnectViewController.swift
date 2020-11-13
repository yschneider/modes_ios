//
//  ConnectViewController.swift
//  modes-mobile-ios
//
//  Created by Joseph Sortino on 9/4/20.
//
import Foundation
import UIKit


class ConnectViewController: UIViewController {

    @IBOutlet weak var customNavBar: CustomNavigationBar!
    
    @objc func goHome(){
        print("goHome is running")
        tabBarController!.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Logo as Home Button
        customNavBar.leftButton.addTarget(self, action: #selector(self.goHome), for: UIControl.Event.touchUpInside)
        
        //link Hamburger Menu to View
        customNavBar.rightButton.addTarget(self, action: #selector(SSASideMenu.presentRightMenuViewController), for: UIControl.Event.touchUpInside)
        
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: self.customNavBar.leftButton)
        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.customNavBar.leftButton)
            
    }
    
    
    @IBAction func makeCall(_ sender: Any) {
        FirebaseUtility.shared.connectInteraction(connectMethod: "call")
             let phoneURL = URL(string: "tel://8003429647")!
          UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
      }


    @IBAction func internationalCalling(_ sender: Any) {
        FirebaseUtility.shared.connectInteraction(connectMethod: "international")
        let webUrl = URL(string: "https://www.militaryonesource.mil/international-calling-options")!
                                   UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        
    }

    
    @IBAction func openWeblink(_ sender: Any) {
        FirebaseUtility.shared.connectInteraction(connectMethod: "website")
        let webUrl = URL(string: "https://www.militaryonesource.mil/")!
                 UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func OpenSubscribeLink(_ sender: Any) {
            /*
           let webUrl = URL(string: "https://public.govdelivery.com/accounts/USDODMILITARYONESOURCE/subscriber/new?topic_id=USDODMILITARYONESOURCE_54")!
                     UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
            */
        
            FirebaseUtility.shared.connectInteraction(connectMethod: "subscribe")
            let storyboard = UIStoryboard(name: "InAppBrowser", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "InAppBrowserVC") as! InAppBrowserVC
            vc.urlString = "https://public.govdelivery.com/accounts/USDODMILITARYONESOURCE/subscriber/new?topic_id=USDODMILITARYONESOURCE_54"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated:true, completion:nil)
        
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
    
    @IBAction func OpenFacebook(_ sender: Any) {
        //let webUrl = URL(string: "https://www.facebook.com/military.1source")!
        //UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        if let url = URL(string: "https://www.facebook.com/military.1source") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
                
            }
        }
    }
    

    @IBAction func openTwitter(_ sender: Any) {
        //let webUrl = URL(string: "https://twitter.com/military1source")!
        //UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        if let url = URL(string: "https://twitter.com/military1source") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
    }
    
    
    
    @IBAction func openYoutube(_ sender: Any) {
        //let webUrl = URL(string: "https://www.youtube.com/user/Military1Source")!
        //UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        if let url = URL(string: "https://www.youtube.com/user/Military1Source") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
        
    }
    
    
    @IBAction func openInstagram(_ sender: Any) {
        //let webUrl = URL(string: "https://www.instagram.com/military1source")!
        //UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        if let url = URL(string: "https://www.instagram.com/military1source/") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
    }
    
    
    @IBAction func openPinterest(_ sender: Any) {
        //let webUrl = URL(string: "https://www.pinterest.com/military1source/")!
        //UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        if let url = URL(string: "https://www.pinterest.com/military1source/") {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
    }
    
    
    
    @IBAction func openLiveChat(_ sender: Any) {
        
         let storyboard = UIStoryboard(name: "InAppBrowser", bundle: nil)
         let vc = storyboard.instantiateViewController(withIdentifier: "InAppBrowserVC") as! InAppBrowserVC
         //Chat Link
         vc.urlString = "https://livechat.militaryonesourceconnect.org/chatmobile/"
         //FAQ on Chat
        //vc.urlString = "https://livechat.militaryonesourceconnect.org/chatmobile/faq.html"
         vc.modalPresentationStyle = .fullScreen
         self.present(vc, animated:true, completion:nil)
         
    }
    
    
    @IBAction func openLiveChat_External(_ sender: Any) {
        let webUrl = URL(string: "https://livechat.militaryonesourceconnect.org/chatmobile/")!
                            UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        
    }
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ConnectViewController: ExternalAlertViewDelegate {
    
    func okButtonTapped(urltovisit: URL) {
        print("okButtonTapped with \(urltovisit) ")
        UIApplication.shared.open(urltovisit, options: [:])
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }
}
