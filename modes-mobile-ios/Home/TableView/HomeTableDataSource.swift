//  HomeTableDataSource.swift

import UIKit

class HomeTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    

    
    
    var viewModel : HomeViewModel?
    var parentView : HomeTableView?

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if(viewModel?.topic == nil ){
            return 0
            
        }
        else{
            return viewModel?.getGuides(topic: viewModel?.topic ?? "").count ?? 0
        }
       
    }
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
 */

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableCell
        
        let guide = viewModel?.getHomeGuides(topic: viewModel?.topic ?? "")[indexPath.row]
        
        //cell.guideImage.image = UIImage(named: "guide_placeholder")
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("small-images/"+(guide?.GuideImage)! + "-200x200.jpg")
            cell.guideImage.image    = UIImage(contentsOfFile: imageURL.path)
           // Do whatever you want with the image
        }
        
        //cell.guideImage.image = UIImage(named: (guide?.GuideImage)! + "-200x200.jpg", in: nil, compatibleWith: nil)
        cell.guideImage.contentMode = UIImageView.ContentMode.scaleAspectFill
        cell.guideImage.clipsToBounds = true
        cell.guideImage.layer.masksToBounds = true
        
        //cell.backgroundColor = UIColor(hex: myBkgColor[indexPath.item])
        //cell.imageView.image = UIImage(named: myImages[indexPath.item])
        //cell.label.text = viewModel?.getGuides(topic: viewModel?.topic ?? "")[indexPath.row]
        cell.label.text = guide?.GuideTitle
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.1
        cell.layer.masksToBounds = false //<-
        
        //cell.layer.backgroundColor = UIColor.white.cgColor
        //tableView.delaysContentTouches = false
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    
        var selectedGuide = viewModel?.getGuides(topic: viewModel?.topic ?? "")[indexPath.row]
        FirebaseUtility.shared.searchResultSelected(contentType: "guide", contentTitle: selectedGuide!, category: viewModel!.topic )
        
        let app = UIApplication.shared.delegate as! AppDelegate
        app.mainViewController?.selectedIndex = 1
        app.mainViewController?.guidesVC?.vc3?.fromHomeVC = true
        app.mainViewController?.guidesVC?.vc3?.backtoSearchResults = true
        app.mainViewController?.guidesVC?.viewModel?.selectedGuide = selectedGuide!
        app.mainViewController?.guidesVC?.vc3?.loadGuide()
        app.mainViewController?.guidesVC?.showOverlay(view: (app.mainViewController?.guidesVC?.DetailsGuideCont)!)
    
   
    
        /*
        let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MilLifeDetailsGuideContVC") as! MilLifeDetailsGuideContVC
        vc.selectedGuide = selectedGuide
    
    
        self.parentView?.parentVc?.parentVc?.present(vc, animated: true)
        */
        
    
        
    }
    

}
