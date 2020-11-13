//
//  AboutVC.swift
//  modes-mobile-ios
//
//  Created by Neal Gentry on 9/9/20.
//

import UIKit

class AboutVC: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var btnLegalAdmin: UIButton!
    
    @IBAction func closeBtnTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_onesourceTouched(_ sender: Any) {
        if let url = URL(string: "http://www.militaryonesource.mil") {
                   if UIApplication.shared.canOpenURL(url) {
                       UIApplication.shared.open(url, options: [:])
                   }
        }
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
    
    @IBAction func btn_dodlogoTouched(_ sender: Any) {
        if let url = URL(string: "http://www.defense.gov") {
                   if UIApplication.shared.canOpenURL(url) {
                       //UIApplication.shared.open(url, options: [:])
                        presentExternalAlert(myURL: url)
                   }
        }
    }
    
    @IBAction func btnLegalAdminTouched(_ sender: Any) {
            let storyboard = UIStoryboard(name: "InAppBrowser", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "InAppBrowserVC") as! InAppBrowserVC
            vc.urlString = "https://www.militaryonesource.mil/legal-security"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated:true, completion:nil)
    }
    
    @IBOutlet weak var customNavBar: CustomNavigationBar!
    
    //For Sending Back to Previous Page
    var delegate : returntoPreviousProtocol?
    
    @objc func goHome(){
        print("goHome is running")
        /*
        let app = UIApplication.shared.delegate as! AppDelegate
        self.dismiss(animated: true, completion: nil)
        app.mainViewController?.selectedIndex = 0
        */
        delegate?.rtPM_GoHome?()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Logo as Home Button
        customNavBar.leftButton.addTarget(self, action: #selector(self.goHome), for: UIControl.Event.touchUpInside)
        
        customNavBar.rightButton.isHidden = true
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

extension AboutVC: ExternalAlertViewDelegate {
    
    func okButtonTapped(urltovisit: URL) {
        print("okButtonTapped with \(urltovisit) ")
        UIApplication.shared.open(urltovisit, options: [:])
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }
}
