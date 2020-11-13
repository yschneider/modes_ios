//
//  UserSettingsLocationsViewController.swift
//  modes-mobile-ios
//
//  Created by yada on 8/22/20.
//

import UIKit
import CoreLocation

class UserSettingsInstallationsViewController: UIViewController {

    var parentVc : UserSettingsViewController?
    
    let picker: UIPickerView = UIPickerView()
    
    var alert : UIAlertController?
    
    var filteredArray = [String]()
    var geoLocation = false
    
    //Top Buttons
    @IBOutlet weak var indBtn1Install: UIButton!
    @IBOutlet weak var indBtn2Install: UIButton!
    @IBOutlet weak var indBtn3Install: UIButton!
    
    
    var mySelect = ""
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var searchInstBtn: UIButton!
    
    //This Calls the Manual Location Search
    @IBAction func touchSearchInstBtn(_ sender: Any) {
        self.parentVc?.viewModel?.addObserver(self, forKeyPath: "dataLoaded", options: [.new, .old], context: nil)
        
        gotoSearchInstalltions()
    }
    
    @IBOutlet weak var textLocatin: UITextField!
    
    //This Calls the GeoLocation Methods
    @IBAction func touchLocation(_ sender: Any) {
        self.parentVc?.viewModel?.addObserver(self, forKeyPath: "dataLoaded", options: [.new, .old], context: nil)
        goGeoLocate()
    }

    @IBAction func touch1(_ sender: Any) {
       self.parentVc?.showPage1()
    }

    @IBAction func touch3(_ sender: Any) {
       self.parentVc?.showPage3()
    }
    
    func showOverlay(_ title: String){
        //alert = UIAlertController(title: nil, message: "Loading Location...", preferredStyle: .alert)
        alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert?.view.addSubview(loadingIndicator)
        present((alert)!, animated: true, completion: {
        
        })
        
    }
    
    func hideOverlay(){
        DispatchQueue.main.async {
            //dismiss the overlay
            self.alert?.dismiss(animated: true, completion: {
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textLocatin.delegate = self
                
        picker.delegate = self
        picker.dataSource = self
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        picker.isHidden = true
              
        picker.backgroundColor = UIColor.white


        picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
    }
    
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        // we need to chars to search
        
        

    }
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        
        //Look for Error in Search Installations
        self.parentVc?.viewModel?.addObserver(self, forKeyPath: "hasDataError", options: [.new,.old], context: nil)
        
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func gotoSearchInstalltions(){
        print("In gotoSearchInstalltions")
        geoLocation = false
        showOverlay("Loading Installations")
        parentVc?.viewModel?.getInstallations()
        //self.performSegue(withIdentifier: "LocTableSegue", sender: nil)
    }
    
    func goGeoLocate(){
        print ("In GeoLocate")
        geoLocation = true
        showOverlay("Loading Location")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    
        if keyPath == "dataLoaded"{
            print("dataLoaded happend")
            print(change![NSKeyValueChangeKey.newKey] as!  Bool)
            let value = change![NSKeyValueChangeKey.newKey] as!  Bool
            if(!value){
                return
            }
        
            //Remove Loading Overlay
            hideOverlay()
        
            DispatchQueue.main.async {
                //dismiss the overlay
                //self.alert?.dismiss(animated: true, completion: {
                //})
                //self.dismiss(animated: false, completion: nil)
                 
                let names = self.parentVc?.viewModel?.locationsModel.items!.map { $0!.name! }
                self.filteredArray = names!
                
                
                self.performSegue(withIdentifier: "LocTableSegue", sender: nil)
            }
        }
        
        //Error Handling
        if keyPath == "hasDataError"  {
            let seconds = 0.75
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                print("Something else happened, hide the alert")
                //Hide the Alert
                self.hideOverlay()
                //self.parentVc?.viewModel?.removeObserver(self, forKeyPath: "hasDataError")
            }
        }
        
    }
    
    
    //TableView Installations Segue
    //Segue for passing data forward
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! LocTableViewController
        vc.viewModel = parentVc?.viewModel
        vc.fromGeoLoc = geoLocation
        if geoLocation == false {
            vc.namesArr = (parentVc?.viewModel?.locationsModel.items!.map { $0!.name! })!
        } else {
            vc.namesArr = filteredArray
        }
    }
    
    //Segue for passing data back
    // This is your unwind Segue, and it must be a @IBAction
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        let source = segue.source as? LocTableViewController // This is the source
        print("Back on presenting VC's unwindtoViewController method")
        
        if source?.backWithData == true {
            mySelect = source!.mySelection
            print("mySelect: ", mySelect)
            
            searchInstBtn.setTitle(mySelect, for: .normal)
            //self.parentVc?.viewModel?.setInstallation(installation: mySelect ?? "")
            
            //Set Name to SharedPrefs
            PreferencesUtil.shared.installationName = mySelect
            FirebaseUtility.shared.InstallationSelected(installationName: mySelect)
            
            let seconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.parentVc?.twoComplete = true
                self.parentVc?.showPage3()
            }
            
            //self.parentVc?.twoComplete = true
            //self.parentVc?.showPage3()
            
            
        } else {
            //back from upper right button press
            //navigate to the other desired screen
            print("Switching Location Screens")
            let seconds = 0.5
            if source?.fromGeoLoc == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.gotoSearchInstalltions()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.goGeoLocate()
                }
            }
        }
        
        
    }
    
    
    
}



extension UserSettingsInstallationsViewController : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text?.count ?? 0 > 2){
           
            let names = parentVc?.viewModel?.locationsModel.items!.map { $0!.name! }
            
            //let names = parentVc?.viewModel?.locationsModel.items.map { $0[0]}
            print(names)   //["Apples", "Banana", "Orange"]
            
            
            self.filteredArray = names!.filter { $0.range(of: textField.text!, options: .caseInsensitive) != nil }
            self.filteredArray.insert("", at: 0)
           
            picker.reloadAllComponents()
            picker.isHidden = false
            
            // set accessibility focus to picker
            UIAccessibility.post(notification: .layoutChanged, argument: picker)
            
            textField.resignFirstResponder()
         
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.filteredArray.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
            let row = self.filteredArray[row]
            return row
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(row == 0){
            return
        }
        else{""
            textLocatin.text = self.filteredArray[row]
            pickerView.isHidden = true
            //self.parentVc?.viewModel?.setInstallation(installation: textLocatin.text ?? "")
        }
        
    }
}

extension UserSettingsInstallationsViewController  : CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                self.hideOverlay()
                   return
               }
        
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                self.parentVc?.viewModel?.addObserver(self, forKeyPath: "dataLoaded", options: [.new, .old], context: nil)
                
                self.parentVc?.viewModel?.city = pm.locality ?? ""
                self.parentVc?.viewModel?.getInstallationsByPostal(postalCode: pm.postalCode!, distance: 25)
                
                
               } else {
                   print("Problem with the data received from geocoder")
               }
           })
        }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("problem with location \(error.localizedDescription)")
            dismiss(animated: false, completion: nil)
       }
    
    
}