//
//  BenefitsDetailsContVC.swift
//  modes-mobile-ios
//
//  Created by Neal Gentry on 9/3/20.
//

import UIKit

class BenefitsDetailsContVC: UIViewController {

    var selectedBenefit : String?
    var parentVc : BenefitsController?
    var benefit : Benefit?
    
    var fromBenefitsVC = false
    var fromHomeVC = false
    var backtoSearchResults = false
    var fromGuidesVC = false
    var fromFavVC = false
   
    //page elements
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var benefitsTitle: UILabel!
    
    
    @IBOutlet weak var benefitsText1: UITextView!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    @IBAction func touchFavorie(_ sender: Any) {
        
        ModesDb.shared.setBenefitavorite(favorite: !(benefit?.favorite ?? false), name: (benefit?.Benefit)!)
        benefit?.favorite = !(benefit?.favorite ?? false)
        if((benefit?.favorite ?? false)){
            buttonFavorite.setImage(UIImage.init(named: "favorites_red"), for: UIControl.State.normal)
            buttonFavorite.setBackgroundImage(UIImage.init(named: "favorites_red"), for: UIControl.State.normal)
            buttonFavorite.accessibilityTraits.insert(.selected)
            
            FirebaseUtility.shared.FavoriteAdded(screenName: (benefit?.Benefit)!, contentType: "Benefit", contentTitle: (benefit?.Benefit)!)
        }
        else{
            buttonFavorite.setImage(UIImage.init(named: "favorite_unselected"), for: UIControl.State.normal)
            buttonFavorite.setBackgroundImage(UIImage.init(named: "favorite_unselected"), for:  UIControl.State.normal)
            buttonFavorite.accessibilityTraits.remove(.selected)
        }
        
    }
    
    @IBAction func backBtnTouched(_ sender: Any) {
      print("Back Button Touched")
        //if(selectedBenefit != nil){
        if fromBenefitsVC == false {
            print("Not from the Benefits Tab, going back to original sender Tab")
            let app = UIApplication.shared.delegate as! AppDelegate
            if fromHomeVC == true {
                print("fromHomeVC is true, going home")
                app.mainViewController?.homeVC?.backtoSearchResults = backtoSearchResults
                app.mainViewController?.homeVC?.keepHorzScrollPosition = true
                app.mainViewController?.selectedIndex = 0
                fromHomeVC = false
            }
            if fromGuidesVC == true {
                print("fromeGuidesVC is true, going to MilLife Guides")
                //app.mainViewController?.guidesVC?.backtoSearchResults = backtoSearchResults
                //app.mainViewController?.guidesVC?.keepHorzScrollPosition = true
                app.mainViewController?.selectedIndex = 1
                fromGuidesVC = false
            }
            if fromFavVC == true {
                print("fromeFavVC is true, going to Favorites")
                NotificationCenter.default.post(name: Notification.Name("benefit_closed"), object: nil)
                app.mainViewController?.selectedIndex = 3
                fromFavVC = false
            }
            
            
            /*
            self.dismiss(animated: true) {
                 NotificationCenter.default.post(name: Notification.Name("benefit_closed"), object: nil)
            }
            */
        }
        else{
            print("fromBenefitsVC is true, going back to BenefitsMain")
            parentVc?.showMainView(view: parentVc!.DetailsBenefits)
            fromBenefitsVC = false
        }
    }
    
    @IBAction func favoritesBtnTouched(_ sender: Any) {
        print("Favorites Button Touched")
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
    
    @IBAction func benefitDetailsBtnTouched(_ sender: Any) {
       // if let url = URL(string: "http://www.militaryonesource.mil") {
        print("benefitDetailsBtnTouched")
        FirebaseUtility.shared.benefitDetailsViewed(screenName: (benefit?.Benefit)!)
        if let url = URL(string: benefit!.BenefitLink!) {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
    }
    
    
    func loadBenefit(){
        if((selectedBenefit) != nil){
            
            var viewModel = BenefitsViewModel()
            viewModel.selectedBenefit = selectedBenefit!
            
            self.benefit = viewModel.getSelectedBenefit()
        }
        else{
        
            benefit = parentVc?.viewModel?.getSelectedBenefit()
        }
        self.benefitsTitle.text = benefit?.Benefit
        
        
       // benefitsText1.numberOfLines = 0
       // benefitsText1.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //self.benefitsText.text = benefit?.LongDescription
        
        let attributedString = NSMutableAttributedString(string: benefit?.LongDescription ?? "")

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 4 // Whatever line spacing you want in points

        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        // *** Set Attributed String to your label ***
        benefitsText1.attributedText = attributedString
        
        
        
        var isFavorite = ""
        if((benefit?.favorite ?? false)){
            buttonFavorite.setImage(UIImage.init(named: "favorites_red"), for: UIControl.State.normal)
            buttonFavorite.setBackgroundImage(UIImage.init(named: "favorites_red"), for: UIControl.State.normal)
            buttonFavorite.accessibilityTraits.insert(.selected)
            
            isFavorite = "yes"
        }
        else{
            buttonFavorite.setImage(UIImage.init(named: "favorite_unselected"), for: UIControl.State.normal)
            buttonFavorite.setBackgroundImage(UIImage.init(named: "favorite_unselected"), for:  UIControl.State.normal)
            buttonFavorite.accessibilityTraits.remove(.selected)
            
            isFavorite = "no"
        }
        
        benefitsText1.translatesAutoresizingMaskIntoConstraints = false
        //arg.sizeToFit()
        benefitsText1.isScrollEnabled = false
        benefitsText1.sizeToFit()
        
        if(benefit != nil){
        
            FirebaseUtility.shared.ScreenView(screenName: (self.benefit?.Benefit)!, contentType: "Benefit", contentTitle: (self.benefit?.Benefit)!, isFavorite: isFavorite)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loadBenefit()
        
        
    }
    
    //override func viewDidAppear(_ animated: Bool) {
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
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

extension BenefitsDetailsContVC: ExternalAlertViewDelegate {
    
    func okButtonTapped(urltovisit: URL) {
        print("okButtonTapped with \(urltovisit) ")
        UIApplication.shared.open(urltovisit, options: [:])
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }
}

