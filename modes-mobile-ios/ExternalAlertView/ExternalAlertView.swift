

import UIKit

protocol ExternalAlertViewDelegate: class {
    func okButtonTapped(urltovisit: URL)
    func cancelButtonTapped()
}

class ExternalAlertView: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var delegate: ExternalAlertViewDelegate?
    
    var myURL = URL(string: "https://www.google.com")
    
    /*
    var allowedURLs = [URL(string: "https://www.militaryonesource.mil"), URL(string: "https://www.americanforcestravel.com"), URL(string: "https://mycaa.militaryonesource.mil/mycaa"), URL(string: "https://blog-brigade.militaryonesource.mil"), URL(string: "https://www.militaryonesourceconnect.org/achievesolutions/en/militaryonesource/home.do"), URL(string: "https://planmydeployment.militaryonesource.mil"), URL(string: "https://efmpeducationdirectory.militaryonesource.mil"), URL(string: "https://msepjobs.militaryonesource.mil/msep/home"), URL(string: "https://planmymove.militaryonesource.mil"), URL(string: "https://myseco.militaryonesource.mil/portal"), URL(string: "https://statepolicy.militaryonesource.mil"), URL(string: "https://installations.militaryonesource.mil"), URL(string: "https://millifelearning.militaryonesource.mil")]
     */
    
    var allowedURLs = [URL(string: "www.militaryonesource.mil"), URL(string: "www.americanforcestravel.com"), URL(string: "mycaa.militaryonesource.mil/mycaa"), URL(string: "blog-brigade.militaryonesource.mil"), URL(string: "www.militaryonesourceconnect.org/achievesolutions/en/militaryonesource/home.do"), URL(string: "planmydeployment.militaryonesource.mil"), URL(string: "efmpeducationdirectory.militaryonesource.mil"), URL(string: "msepjobs.militaryonesource.mil/msep/home"), URL(string: "planmymove.militaryonesource.mil"), URL(string: "myseco.militaryonesource.mil/portal"), URL(string: "statepolicy.militaryonesource.mil"), URL(string: "installations.militaryonesource.mil"), URL(string: "millifelearning.militaryonesource.mil")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Check if URL is Allowed, if So Do not Show Alert
        print("ExternalAlertView myURL: ", myURL)
        let checkURL = URL(string: (myURL?.host)!)
        print("checkURL: ", checkURL)
        if allowedURLs.contains(checkURL) || allowedURLs.contains(myURL){
            delegate?.okButtonTapped(urltovisit: myURL!)
            let seconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                 self.dismiss(animated: false, completion: nil)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
            setupView()
            animateView()
       
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 5
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        okButton.layer.cornerRadius = 10
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @IBAction func onTapCancelButton(_ sender: Any) {
        //delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: {self.delegate?.cancelButtonTapped()})
    }
    
    @IBAction func onTapOkButton(_ sender: Any) {
        //delegate?.okButtonTapped(urltovisit: myURL!)
        self.dismiss(animated: true, completion: {self.delegate?.okButtonTapped(urltovisit: self.myURL!)})
    }
    
    
}
