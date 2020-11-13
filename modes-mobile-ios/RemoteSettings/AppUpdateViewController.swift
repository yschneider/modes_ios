//
//  AppUpdateViewController.swift
//  modes-mobile-ios
//
//  Created by Chris Fletcher on 10/15/20.
//

import UIKit

class AppUpdateViewController: UIViewController {
    
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtUpdateMessage: UITextView!
    
    @IBOutlet var viewMain: UIView!
    @IBOutlet weak var AlertView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var alertview_H_Constraint: NSLayoutConstraint!
    @IBOutlet weak var btnUpdate_Bottom_Const: NSLayoutConstraint!
    
    var appUpdateSettings: AppUpdateSettings!

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnUpdate.layer.cornerRadius = 10
        AlertView.layer.cornerRadius = 5
        
        if appUpdateSettings != nil {
            txtUpdateMessage.text = appUpdateSettings.updateMessage
        
            if appUpdateSettings.forceUpdate {
                btnCancel.isHidden = true
                lblTitle.text = "Update Required"
                alertview_H_Constraint.constant = 180
                btnUpdate_Bottom_Const.constant = 20
            } else {
                btnCancel.isHidden = false
                lblTitle.text = "Update Available"
                alertview_H_Constraint.constant = 200
                btnUpdate_Bottom_Const.constant = 45
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        txtUpdateMessage.centerVertically()
    }
    
    @IBAction func btnUpdateTouched(_ sender: Any) {
        if let url = URL(string: "https://itunes.apple.com/us/app/apple-store/id1532124387?mt=8") {
            //https://apps.apple.com/us/app/my-military-onesource/id1532124387
            if #available(iOS 10.0, *) {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else {
                 if UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
    }
    
    @IBAction func btnCancelTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UITextView {

  func centerVertically() {
      let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
      let size = sizeThatFits(fittingSize)
      let topOffset = (bounds.size.height - size.height * zoomScale) / 2
      let positiveTopOffset = max(1, topOffset)
      contentOffset.y = -positiveTopOffset
  }

}
