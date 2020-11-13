//  Right_VertTwoCollDataSource.swift

import UIKit

class Right_VertTwoCollDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var viewModel : HomeViewModel?
    var parentVc : RightSideMenuVC?
    
    var myLabels = ["COVID-19", "Financial & Legal", "Tile 3", "Again More", "And Again", "And Much More", "COVID-19", "Financial & Legal", "Tile 3", "Again More", "And Again", "And Much More", "And Again", "And Much More"]
    
    var myImages = ["menuNetLink_1", "menuNetLink_2", "menuNetLink_3", "menuNetLink_4", "menuNetLink_5", "menuNetLink_6", "menuNetLink_7", "menuNetLink_8", "menuNetLink_9", "menuNetLink_10", "menuNetLink_11", "menuNetLink_12", "menuNetLink_13", "menuNetLink_14" ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return viewModel?.getBenefits(topic: viewModel?.topic ?? "").count ?? 0
        
        //return parentVc?.parentVc?.viewModel?.categories.count ?? 0
        return myImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Right_VertTwoCollCell", for: indexPath) as! Right_VertTwoCollCell
        
       
        //cell.label.text = parentVc?.parentVc?.viewModel?.categories[indexPath.row]
        //cell.label.text = myLabels[indexPath.item]
        //cell.label.text = viewModel?.getBenefits(topic: viewModel?.topic ?? "")[indexPath.row]
        
        cell.linkImage.image = UIImage(named: myImages[indexPath.item])
        
        
        
        collectionView.delaysContentTouches = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        print ("Selected: ", indexPath.row)
        var url = URL(string: "http://www.militaryonesource.mil")
        switch indexPath.row {
        case 0:
            FirebaseUtility.shared.menuItemSelected(menuItem: "travel")
            url = URL(string: "https://www.americanforcestravel.com/")
        case 1:
            FirebaseUtility.shared.menuItemSelected(menuItem: "blog")
        url = URL(string: "https://blog-brigade.militaryonesource.mil/")
        case 2:
            FirebaseUtility.shared.menuItemSelected(menuItem: "efmp_and_me")
        url = URL(string: "https://efmpandme.militaryonesource.mil/")
        case 3:
            FirebaseUtility.shared.menuItemSelected(menuItem: "installations")
        url = URL(string: "https://installations.militaryonesource.mil/")
        case 4:
            FirebaseUtility.shared.menuItemSelected(menuItem: "onsesource-connect")
        url = URL(string: "https://www.militaryonesourceconnect.org/")
        case 5:
            FirebaseUtility.shared.menuItemSelected(menuItem: "msepjobs")
        url = URL(string: "https://msepjobs.militaryonesource.mil/msep/home")
        case 6:
            FirebaseUtility.shared.menuItemSelected(menuItem: "millifelearning")
        url = URL(string: "https://millifelearning.militaryonesource.mil/")
        case 7:
            FirebaseUtility.shared.menuItemSelected(menuItem: "mycaa")
        url = URL(string: "https://mycaa.militaryonesource.mil/mycaa/")
        case 8:
            FirebaseUtility.shared.menuItemSelected(menuItem: "planmymove")
        url = URL(string: "https://planmymove.militaryonesource.mil/")
        case 9:
            FirebaseUtility.shared.menuItemSelected(menuItem: "myseco")
        url = URL(string: "https://myseco.militaryonesource.mil/portal/")
        case 10:
            FirebaseUtility.shared.menuItemSelected(menuItem: "efmpeducationdirectory")
        url = URL(string: "https://efmpeducationdirectory.militaryonesource.mil/")
        case 11:
            FirebaseUtility.shared.menuItemSelected(menuItem: "statepolicy")
        url = URL(string: "https://statepolicy.militaryonesource.mil/")
        case 12:
            FirebaseUtility.shared.menuItemSelected(menuItem: "onesource")
        url = URL(string: "https://www.militaryonesource.mil/")
        case 13:
            FirebaseUtility.shared.menuItemSelected(menuItem: "planmydeployment")
        url = URL(string: "https://planmydeployment.militaryonesource.mil/")
        default:
            print("default ran")
        }
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:])
        }
        
        
        
        
        
        //parentVc?.parentVc?.viewModel?.selectedCategory = parentVc?.parentVc?.viewModel?.categories[indexPath.row] as! String
        //parentVc?.showGuidesTableonParent()
        //parentVc?.parentVc?.right_guides_tableview.tableView.reloadData()
        //parentVc?.parentVc?.showOverlay(view: (parentVc?.parentVc?.GuidesTableView)!)
        
    }

}



