//
//  MainTabViewController.swift
//  modes-mobile-ios
//
//  Created by yada on 9/17/20.
//

import UIKit

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    var homeVC : HomeViewController?
    var benefitsVC : BenefitsController?
    var guidesVC : MilLifeGuidesController?
    var favoritesVC : FavoritesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        let app = UIApplication.shared.delegate as! AppDelegate
        
        app.mainViewController = self
        
        for vc in self.viewControllers!{
            if vc is BenefitsController{
                benefitsVC = vc as! BenefitsController
            }
            if vc is MilLifeGuidesController{
                guidesVC = vc as! MilLifeGuidesController
            }
            if vc is HomeViewController{
                homeVC = vc as! HomeViewController
            }
            if vc is FavoritesViewController{
                favoritesVC = vc as! FavoritesViewController
            }
            
        }
    
        // Do any additional setup after loading the view.
    }
    
    func clearNavFlags(){

        guidesVC?.vc3?.fromHomeVC = false
        guidesVC?.vc3?.fromMilLifeGuides = false
        guidesVC?.vc3?.fromFavVC = false
        
        benefitsVC?.vc3?.fromHomeVC = false
        benefitsVC?.vc3?.fromGuidesVC = false
        benefitsVC?.vc3?.fromBenefitsVC = false
        benefitsVC?.vc3?.fromFavVC = false
                
    }
    
    func loadBenefit(){
        benefitsVC?.viewDidLoad()
        
    }
    // called whenever a tab button is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        //Reset Back Button on Guides Details and Benefits Details
        clearNavFlags()
        
        if viewController is HomeViewController {
            print("First tab")
            var vc = viewController as! HomeViewController
            vc.viewDidLoad()
            vc.viewWillAppear(true)
            
            
        } else if viewController is MilLifeGuidesController {
            print("Second tab")
            var vc = viewController as! MilLifeGuidesController
            vc.viewDidLoad()
        }
        else if viewController is BenefitsController {
            print("third tab")
            var vc = viewController as! BenefitsController
            vc.viewDidLoad()
        }
        else if viewController is FavoritesViewController {
            print("fourth tab")
            var vc = viewController as! FavoritesViewController
            vc.viewDidLoad()
        }
        else if viewController is ConnectViewController {
            print("fifth tab")
            var vc = viewController as! ConnectViewController
            vc.viewDidLoad()
        }
        
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
