//
//  MilLifeDetailsGuideContVC.swift
//  modes-mobile-ios
//
//  Created by Neal Gentry on 9/3/20.
//

import UIKit

class MilLifeDetailsGuideContVC: UIViewController {
    
    var fromMilLifeGuides = false
    var fromHomeVC = false
    var backtoSearchResults = false
    var fromFavVC = false

    @IBOutlet weak var imgGuide: UIImageView!
    
    var selectedGuide : String?
    var parentVc : MilLifeGuidesController?
    
    var guide: Guide?
    @IBOutlet weak var ml_articles_tableview: ML_Articles_TableView!
    @IBOutlet weak var ml_benefits_tableview: ML_Benefits_TableView!
    @IBOutlet weak var ml_websites_tableview: ML_Websites_TableView!
    @IBOutlet weak var ml_connect_tableview: ML_Connect_TableView!
    
    //Constraint Heights
    @IBOutlet weak var constraintH_benefits_tv: NSLayoutConstraint!
    @IBOutlet weak var constraintH_websites_tv: NSLayoutConstraint!
    @IBOutlet weak var constraintH_connect_tv: NSLayoutConstraint!
    
    @IBOutlet weak var lblExpertsHeader1: UILabel!
    
    @IBOutlet weak var lblExpertOverview: UILabel!
    
    
    //page elements
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblTextOverVIew: UILabel!
    
    @IBOutlet weak var lblArticles: UILabel!
    @IBOutlet weak var btnMoreArticles: UIButton!
    
    @IBOutlet weak var lblBenefits: UILabel!
    @IBOutlet weak var btnMoreBenefits: UIButton!
    
    @IBOutlet weak var viewSpeakwith: UIView!
    
    @IBOutlet weak var buttonFavorite: UIButton!
    @IBAction func touchFavorite(_ sender: Any) {
        
        ModesDb.shared.setGuideFavorite(favorite: !(guide?.favorite ?? false), name: (guide?.Guide)!)
        guide?.favorite = !(guide?.favorite ?? false)
        if((guide?.favorite ?? false)){
            buttonFavorite.setImage(UIImage.init(named: "favorites_red"), for: UIControl.State.normal)
            buttonFavorite.setBackgroundImage(UIImage.init(named: "favorites_red"), for: UIControl.State.normal)
            buttonFavorite.accessibilityTraits.insert(.selected)
            
            FirebaseUtility.shared.FavoriteAdded(screenName: (guide?.Guide)!, contentType: "MilLife Guide", contentTitle: (guide?.Guide)!)
        }
        else{
            buttonFavorite.setImage(UIImage.init(named: "favorite_unselected"), for: UIControl.State.normal)
            buttonFavorite.setBackgroundImage(UIImage.init(named: "favorite_unselected"), for:  UIControl.State.normal)
            buttonFavorite.accessibilityTraits.remove(.selected)
        }
        
    }
    
    func loadGuide()
    {
        
        guide = Guide()
        guide = parentVc?.viewModel?.getGuide()
        
        selectedGuide = parentVc?.viewModel?.selectedGuide
        
        self.lblTitle.text = guide?.Guide
        self.lblHeader.text = guide?.GuideHeader
        self.lblTextOverVIew.text = guide?.Overview
        self.lblArticles.text = guide?.ArticleHeader
        self.btnMoreArticles.setTitle(guide?.MoreArticlesText, for: .normal)
        self.btnMoreArticles.accessibilityLabel = guide?.MoreArticlesText
        self.btnMoreArticles.titleLabel?.textAlignment = .center
        self.btnMoreBenefits.setTitle(guide?.MoreBenefitsText, for: .normal)
        self.btnMoreBenefits.accessibilityLabel = guide?.MoreBenefitsText
        self.btnMoreBenefits.titleLabel?.textAlignment = .center
        
        //Show only 3rd word on Button
        /*
        let articlesFirstWord = guide?.MoreArticlesText!.components(separatedBy: " ")
        let benefitsFirstWord = guide?.MoreBenefitsText!.components(separatedBy: " ")
        self.btnMoreArticles.setTitle("See more " + articlesFirstWord![2].lowercased() + " articles", for: .normal)
        self.btnMoreBenefits.setTitle("See more " + benefitsFirstWord![2].lowercased() + " benefits", for: .normal)
        */
        
        ml_articles_tableview.tableDataSource.parentVc = self
        ml_articles_tableview.tableView.reloadData()

        ml_benefits_tableview.tableDataSource.parentVc = self
        //Constraint Heights
        let myBenefitsTVCount = self.guide?.listRelatedBenefits?.count ?? 0
        print("Constraints Benefits Count: ", myBenefitsTVCount)
        //Show Max of 4 Benefits
        if myBenefitsTVCount > 4 {
            constraintH_benefits_tv.constant = CGFloat(119 * 4)
        } else {
            constraintH_benefits_tv.constant = CGFloat(119 * (myBenefitsTVCount))
        }
        ml_benefits_tableview.tableView.reloadData()

        ml_websites_tableview.tableDataSource.parentVc = self
        //Constraint Heights
        let myWebTVCount = self.guide?.RelatedWebsitesText?.count ?? 0
        print("Constraints WebSites Count: ", myWebTVCount)
        constraintH_websites_tv.constant = CGFloat(38 * (myWebTVCount) + 30)
        ml_websites_tableview.tableView.reloadData()

        ml_connect_tableview.tableDataSource.parentVc = self
        //Constraint Heights
        let myConnectTVCount = self.guide?.ExpertsText?.count ?? 0
        print("Constraints Connection Count: ", myConnectTVCount)
        constraintH_connect_tv.constant = CGFloat(65 * (myConnectTVCount))
        ml_connect_tableview.tableView.reloadData()
        
        
        lblExpertOverview.text = guide?.ExpertsHeader
        lblExpertsHeader1.text = guide?.ExpertsHeader1
        var isFavorite = ""
        
        if((guide?.favorite ?? false)){
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
        
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("images-large/"+(self.guide?.GuideImage!)! + "-1000x500.jpg")
           imgGuide.image    = UIImage(contentsOfFile: imageURL.path)
           // Do whatever you want with the image
        }
        
        
        //imgGuide.image = UIImage(named: (self.guide?.GuideImage)! + "-1000x500.jpg", in: nil, compatibleWith: nil)
        
        
        print("Debug")
        
        
        
        
        FirebaseUtility.shared.ScreenView(screenName: (guide?.Guide)!, contentType: "MilLife Guide", contentTitle: (guide?.Guide)!, isFavorite: isFavorite)
    }
    
    
    
    func loadGuide1(){
        self.lblTitle.text = guide?.Guide
        self.lblHeader.text = guide?.GuideHeader
        self.lblTextOverVIew.text = guide?.Overview
        self.lblArticles.text = guide?.ArticleHeader
        self.btnMoreArticles.setTitle(guide?.MoreArticlesText, for: .normal)
        self.btnMoreArticles.titleLabel?.textAlignment = .center
        self.btnMoreBenefits.setTitle(guide?.MoreBenefitsText, for: .normal)
        self.btnMoreBenefits.titleLabel?.textAlignment = .center
        
        //Show only 3rd word on Button
        /*
        let articlesFirstWord = guide?.MoreArticlesText!.components(separatedBy: " ")
        let benefitsFirstWord = guide?.MoreBenefitsText!.components(separatedBy: " ")
        self.btnMoreArticles.setTitle("See more " + articlesFirstWord![2].lowercased() + " articles", for: .normal)
        self.btnMoreBenefits.setTitle("See more " + benefitsFirstWord![2].lowercased() + " benefits", for: .normal)
        */
        
        ml_articles_tableview.tableDataSource.parentVc = self
        ml_articles_tableview.tableView.reloadData()

        ml_benefits_tableview.tableDataSource.parentVc = self
        //Constraint Heights
        let myBenefitsTVCount = self.guide?.listRelatedBenefits?.count ?? 0
        print("Constraints Benefits Count: ", myBenefitsTVCount)
        //Show Max of 4 Benefits
        if myBenefitsTVCount > 4 {
            constraintH_benefits_tv.constant = CGFloat(119 * 4)
        } else {
            constraintH_benefits_tv.constant = CGFloat(119 * (myBenefitsTVCount))
        }
        ml_benefits_tableview.tableView.reloadData()

        ml_websites_tableview.tableDataSource.parentVc = self
        //Constraint Heights
        let myWebTVCount = self.guide?.RelatedWebsitesText?.count ?? 0
        print("Constraints WebSites Count: ", myWebTVCount)
        constraintH_websites_tv.constant = CGFloat(38 * (myWebTVCount) + 30)
        ml_websites_tableview.tableView.reloadData()

        ml_connect_tableview.tableDataSource.parentVc = self
        //Constraint Heights
        let myConnectTVCount = self.guide?.ExpertsText?.count ?? 0
        print("Constraints Connection Count: ", myConnectTVCount)
        constraintH_connect_tv.constant = CGFloat(65 * (myConnectTVCount))
        ml_connect_tableview.tableView.reloadData()
        
        
        lblExpertOverview.text = guide?.ExpertsHeader
        lblExpertsHeader1.text = guide?.ExpertsHeader1
        
        var isFavorite = ""
        if((guide?.favorite ?? false)){
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
        
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("images-large/"+(self.guide?.GuideImage!)! + "-1000x500.jpg")
           imgGuide.image    = UIImage(contentsOfFile: imageURL.path)
           // Do whatever you want with the image
        }
        
        //imgGuide.image = UIImage(named: (self.guide?.GuideImage)! + "-1000x500.jpg", in: nil, compatibleWith: nil)
        
        
        FirebaseUtility.shared.ScreenView(screenName: (guide?.Guide)!, contentType: "MilLife Guide", contentTitle: (guide?.Guide)!, isFavorite: isFavorite)
        
        print("Debug")
        
        
        
    }
    
    
    @IBAction func didTouchbtnMoreArticles(_ sender: Any) {
        print("didTouchbtnMoreArticles")
        if let url = URL(string: guide!.MoreArticlesURL!) {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
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
    
    @IBAction func didTouchbtnMoreBenefits(_ sender: Any) {
        print("didTouchbtnMoreBenefits")
        if let url = URL(string: guide!.MoreBenefitsURL!) {
            if UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url, options: [:])
                presentExternalAlert(myURL: url)
            }
        }
        
    }
    
    @IBAction func callButtonTouched(_ sender: Any) {
        
        guard let number = URL(string: "tel://" + "8003429647") else { return }
        UIApplication.shared.open(number)
        
       
    }
    
    
    @IBAction func didTouchDetailsBackBtn(_ sender: Any) {
        
        print("didTouchDetailsBackBtn")
        
        //if(!(selectedGuide?.isEmpty ?? true)){
        if !(fromMilLifeGuides) {
            print("Not from MilLifeGuides Tab, going back to original sender Tab")
            let app = UIApplication.shared.delegate as! AppDelegate
            if fromHomeVC == true {
                //Go Back Home
                print("fromHomeVC is true, going home")
                app.mainViewController?.homeVC?.backtoSearchResults = backtoSearchResults
                app.mainViewController?.homeVC?.keepHorzScrollPosition = true
                app.mainViewController?.selectedIndex = 0
                fromHomeVC = false
            }
            
            if fromFavVC == true {
                //Go To Favorites
                print("fromeFavVC is true, going to Favorites")
                NotificationCenter.default.post(name: Notification.Name("guide_closed"), object: nil)
                app.mainViewController?.selectedIndex = 3
                fromFavVC = false
            }
            
            
            /*
            print("it is Modal")
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: Notification.Name("guide_closed"), object: nil)
                self.parentVc?.showMainView(view: self.parentVc!.DetailsGuideCont)
            }
            */
        }
        else{
            print("it is on MilLifeGuides")
            parentVc?.showMainView(view: parentVc!.DetailsGuideCont)
            fromMilLifeGuides = false
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.accessibilityIdentifier = "detailTitle"

        // Do any additional setup after loading the view.
        viewSpeakwith.layer.cornerRadius = 5
        viewSpeakwith.layer.borderWidth = 0.0
        viewSpeakwith.layer.shadowColor = UIColor.black.cgColor
        viewSpeakwith.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewSpeakwith.layer.shadowRadius = 5.0
        viewSpeakwith.layer.shadowOpacity = 0.1
        viewSpeakwith.layer.masksToBounds = false
        
        /*
        if(!(selectedGuide?.isEmpty ?? true)){
            var viewModel = GuidesViewModel()
            viewModel.selectedGuide = selectedGuide!
            guide = viewModel.getGuide()
            loadGuide1()
        }
        */
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(!(selectedGuide?.isEmpty ?? true)){
        //if !(fromMilLifeGuides) {
            print("Condition1, selectedGuide: ", selectedGuide)
            var viewModel = GuidesViewModel()
            viewModel.selectedGuide = selectedGuide!
            guide = viewModel.getGuide()
            loadGuide1()
        }
        else{
            print("Condition2, selectedGuide: ", selectedGuide)
            loadGuide()
        }
        
        
        
        ml_articles_tableview.tableDataSource.parentVc = self
        ml_articles_tableview.tableView.reloadData()
        
        ml_benefits_tableview.tableDataSource.parentVc = self
        ml_benefits_tableview.tableView.reloadData()
        
        ml_websites_tableview.tableDataSource.parentVc = self
        ml_websites_tableview.tableView.reloadData()
        
        ml_connect_tableview.tableDataSource.parentVc = self
        ml_connect_tableview.tableView.reloadData()
        
        
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func showInAppBrowserfromGuideDetails(url: String){
        print("Back on Main showInAppBrowseronGuideDetails with index: ", index)
        let storyBoard : UIStoryboard = UIStoryboard(name: "InAppBrowser", bundle:nil)

        let nextVC = storyBoard.instantiateViewController(withIdentifier: "InAppBrowserVC") as! InAppBrowserVC
        nextVC.urlString = url
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated:true, completion:nil)
    }
    
    func showRelatedWebsitesfromGuideDetails(urlString: String){
          print ("Back on Details showRelatedWEbsites with index: ", index)
          let trimmedUrl = urlString.trimmingCharacters(in: CharacterSet([" "]))
          if let url = URL(string: trimmedUrl) {
                     if UIApplication.shared.canOpenURL(url) {
                         //UIApplication.shared.open(url, options: [:])
                        presentExternalAlert(myURL: url)
                     }
                 }
      }

}

extension MilLifeDetailsGuideContVC: ExternalAlertViewDelegate {
    
    func okButtonTapped(urltovisit: URL) {
        print("okButtonTapped with \(urltovisit) ")
        UIApplication.shared.open(urltovisit, options: [:])
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped")
    }
}
