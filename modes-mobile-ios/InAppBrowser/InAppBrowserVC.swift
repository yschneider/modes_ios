import UIKit
import WebKit


class InAppBrowserVC: UIViewController, WKNavigationDelegate, WKUIDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var custNavBar: CustomNavigationBar!
    
    var fromRightSideMenu = false
    
    var activityIndicator: UIActivityIndicatorView!
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webView didFinish navigation")
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    
    var urlString : String?
    
    //For Sending Back to Previous Page
    var delegate : returntoPreviousProtocol?
    
    @objc func goHome(){
        print("goHome is running")
        if fromRightSideMenu == false {
            let app = UIApplication.shared.delegate as! AppDelegate
            self.dismiss(animated: true, completion: nil)
            app.mainViewController?.selectedIndex = 0
        } else {
            delegate?.rtPM_GoHome?()
            dismiss(animated: true, completion: nil)
        }
    }
    override func loadView() {
       super.loadView()
       self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("On InAppBrowser")
        
        //Logo as Home Button
        custNavBar.leftButton.addTarget(self, action: #selector(self.goHome), for: UIControl.Event.touchUpInside)
        
        
        custNavBar.rightButton.isHidden = true
        
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        
        // Do any additional setup after loading the view.
        let url = URL(string: urlString!.trimmingCharacters(in: CharacterSet([" "])))
        webView.load(URLRequest(url: url!))
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.isHidden = true

        view.addSubview(activityIndicator)
        
        //Add Swipe Right for Back button functionality
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeRight.direction = .right
            self.view!.addGestureRecognizer(swipeRight)
        
    }
    
    //Swipe Right to use Back Button Functionality
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
            backButtonTouched(self)
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler(false)
            self.dismiss(animated: true, completion: nil)
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))

        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler()
        }))

        self.present(alertController, animated: true, completion: nil)
    }
   
   
    /*
    //This function sets specific links to open in
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            let url = navigationAction.request.url
            guard url != nil else {
                decisionHandler(.allow)
                return
            }
            //Here is the specific URL that will open in iOS Browser (not inAppBrowser)
            if url!.description.lowercased().starts(with: "https://public.militaryonesource.mil/feedback")  {
                decisionHandler(.cancel)
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            } else {
                decisionHandler(.allow)
            }
    }
    
 */
 
    func webView(_ webView: WKWebView,
               createWebViewWith configuration: WKWebViewConfiguration,
               for navigationAction: WKNavigationAction,
               windowFeatures: WKWindowFeatures) -> WKWebView? {
      if navigationAction.targetFrame == nil, let url = navigationAction.request.url, let scheme = url.scheme {
        if ["http", "https", "mailto"].contains(where: { $0.caseInsensitiveCompare(scheme) == .orderedSame }) {
          UIApplication.shared.openURL(url)
        }
      }
      return nil
    }
    
    //Code below would allow _blank links to open inAppBrowser
    /*
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    */
    
    @IBAction func backButtonTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
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
