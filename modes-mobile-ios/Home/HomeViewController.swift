//
//  HomeViewController
//

import UIKit

class HomeViewController: UIViewController {
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var customNavBar: CustomNavigationBar!
    
    var backtoSearchResults = false
    var keepHorzScrollPosition = false

    var viewModel : HomeViewModel = HomeViewModel()
    
    @IBOutlet weak var homeTableView: HomeTableView!
    @IBOutlet weak var MainView1: UIView!
    @IBOutlet weak var MainView2: UIView!
    
    @IBOutlet weak var HomeContView1: UIView!
    @IBOutlet weak var HomeContView2: UIView!
    
    
    @IBOutlet weak var menubutton: UIButton!
    
    @IBOutlet weak var horzCollView: HorzCollView!
    
    
    var vc1 : HomeContView1VC?
    var vc2 : HomeContView2VC?
    
    @IBAction func didtouchbutton(_ sender: Any) {
        
    }
    
    @IBOutlet weak var testMenuButton: UIButton!
    
    var myCards : [HomePageCardModel] = []
    

    @objc func goHome(){
        print("goHome is running")
        //tabBarController!.selectedIndex = 0
        viewWillAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if myCards.count == 0 {
            print("HomveView has not loaded before")
            myCards = viewModel.getSuggestedCards()
        } else {
            print("HomeView has loaded before")
        }
        
        //Logo as Home Button
        customNavBar.leftButton.addTarget(self, action: #selector(self.goHome), for: UIControl.Event.touchUpInside)
        
        
        //link Hamburger Menu to View
        customNavBar.rightButton.addTarget(self, action: #selector(SSASideMenu.presentRightMenuViewController), for: UIControl.Event.touchUpInside)
        
        
        //tabBarController!.viewControllers?.remove(at:5)

        //set focus
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
        
        

        // set a reference back to the parent vc for contained view controllers
        // this is how the childeren should reference the view model
        for child in self.children{
            
            switch child{
                
            case is HomeContView1VC:
                vc1 = (child as! HomeContView1VC)
                (child as! HomeContView1VC).parentVc = self
                (child as! HomeContView1VC).horzCollView.collectionDataSource.viewModel = self.viewModel
            case is HomeContView2VC:
                vc2 = (child as! HomeContView2VC)
                (child as! HomeContView2VC).parentVc = self
            default:
                break
            }
        }
        
        //Add Swipe Right for Back button functionality
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeRight.direction = .right
            self.view!.addGestureRecognizer(swipeRight)
        
    }
    
    //Swipe Right to use Back Button Functionality
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
            if HomeContView2.isHidden == false {
                print("going back from Home Screen Results")
                vc2!.backtoSearch()
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //myCards = viewModel.getSuggestedCards()
    }
    
    
    
    //Set the Initial Focus
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [customNavBar!.leftButton]
    }
    
    override func viewWillAppear(_ Animated: Bool) {
        
        if backtoSearchResults == false {
            HomeContView2.isHidden = true
            HomeContView2.alpha = 0
            HomeContView1.isHidden = false
            HomeContView1.alpha = 1
        } else {
            print("on HomeViewController, backtoSearchResults is true")
            backtoSearchResults = false
        }
        
        if keepHorzScrollPosition == false {
            vc1?.horzCollView.collectionDataSource.viewModel = self.viewModel
            vc1?.horzCollView.collectionView.reloadData()
            vc1?.horzCollView.collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .left, animated: false)
        } else {
            print("on HomeViewController, keepHorizScrollPosition is true")
            keepHorzScrollPosition = false
        }
        
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: self.customNavBar.view)
        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.customNavBar.view)
       
       
        
    }
    
    func didSelectHorzTile(index: Int){
        print("Back on Home with selection: ", index)
        //let mySelCardType = viewModel.getSuggestedCards()[index].cardType
        //let mySelCardTitle = viewModel.getSuggestedCards()[index].cardTitle
        
        let mySelCardType = myCards[index].cardType
        let mySelCardTitle = myCards[index].cardTitle
        
        switch mySelCardType {
        case "MILLIFE GUIDES":
                print("Guides: ", index, mySelCardTitle)
                //Change Pages
                tabBarController!.selectedIndex = 1
            
                //Pass Data
                let nextTab = self.tabBarController!.viewControllers![1] as! MilLifeGuidesController
                //nextTab.viewModel?.selectedGuide = nextTab.viewModel?.getAllGuides()[2] as! String
                nextTab.viewModel?.selectedGuide = (nextTab.viewModel?.getGuidesByName(title: mySelCardTitle!)[0])! 
                nextTab.showOverlay(view: nextTab.DetailsGuideCont)
                nextTab.vc3!.loadGuide()

            
        case "BENEFIT":
                print("Benefits")
                tabBarController!.selectedIndex = 2
                
                //Pass Data
                let nextTab = self.tabBarController!.viewControllers![2] as! BenefitsController
                nextTab.viewModel?.selectedBenefit = (nextTab.viewModel?.getBenefitsByName(title: mySelCardTitle!)[0])!
                nextTab.showOverlay(view: nextTab.DetailsBenefits)
                //nextTab.vc3!.loadBenefit()
            
        case "FAVORITES":
                print("Favorites")
                tabBarController!.selectedIndex = 3
        
        case "CONNECT":
                print("Connect")
                tabBarController!.selectedIndex = 4
        
        case "ABOUT US":
                print("About Us")
                //tabBarController!.selectedIndex = 4
           
        default:
            print("selected type: ", mySelCardType)
            
            
            
        }
        
    }
    
}

