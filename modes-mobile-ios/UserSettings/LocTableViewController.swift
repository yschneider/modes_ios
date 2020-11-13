//
//  LocTableViewController.swift


import UIKit

class LocTableViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgSrch: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblShowingInst: UILabel!
    @IBOutlet weak var lblInstallName: UILabel!
    @IBOutlet weak var btnRightTop: UIButton!
    
    var viewModel : UserSettingsViewModel?
    
    var mySelection = ""
    var backWithData = false
    var searching:Bool = false
    var searchText = ""
    
    //from Geo Located
    var fromGeoLoc = false
    
    //data
    var namesArr = [String]()
    //filtered data from TextField
    var searchNamesArrRes = [String]()
    
    let clearImage = UIImage(named: "search_delete_ic")!
    let searchImage = UIImage(named: "search")!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchClear(_ sender: Any) {
        txtName.text = ""
        searchButton.setImage(searchImage, for: .normal)
        searchText = ""
        searching = false
        self.tableView.reloadData();

    }
    
    @IBAction func backbtnTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func navbtnTouched(_ sender: Any) {
       performSegue(withIdentifier: "unwindSegue", sender: title)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.txtName.isAccessibilityElement = true
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: self.txtName)
        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.txtName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.paddingLeft(inset: 20)
        txtName.layer.cornerRadius = 15.0
        txtName.layer.borderWidth = 2.0
        
        //Assign delegate  don't forget
         txtName.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "LocTable_TableCell", bundle: nil)
        //tableView.register(nib, forCellWithReuseIdentifier: "ML_Connect_TableCell")
        tableView.register(nib, forCellReuseIdentifier: "LocTable_TableCell")
        
        if fromGeoLoc {
            txtName.isHidden = true
            imgSrch.isHidden = true
            searchButton.isHidden = true
            lblInstallName.text = viewModel?.city
            btnRightTop.setImage(UIImage(named: "search"), for: .normal)
            btnRightTop.accessibilityLabel = "Search"
        } else {
            lblShowingInst.isHidden = true
            lblInstallName.isHidden = true
            imgSrch.isHidden = true
            txtName.becomeFirstResponder()
            searchButton.isHidden = false
            
        }
        
        print("namesArr:", namesArr)
        
        namesArr = namesArr.sorted(by: <)
        
        
    }
    
    //Fix for Done Button Accessibility reading the first item on TableView
    func textFieldDidEndEditing(_ textField: UITextField) {
            print("KB is closed")
            let indexPath = IndexPath(row: 0, section: 0)
        if((self.tableView.cellForRow(at: indexPath) != nil)){
            self.tableView.cellForRow(at:indexPath)!.isAccessibilityElement = true
            UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: self.tableView.cellForRow(at:indexPath)!)
            UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.tableView.cellForRow(at:indexPath)!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("Keyboard is Closing")
        return true
    }
    
    @IBAction func txtNameEditingChanged(_ sender: Any) {
        //let searchText  = (txtName.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        searchText  = (txtName.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(searchText.count >= 1) {
            
            searchButton.setImage(clearImage, for: .normal)
            
            //add matching text to arrays
            searchNamesArrRes = namesArr.filter { $0.range(of: searchText, options: .caseInsensitive) != nil }
            searching = true
            self.tableView.reloadData();
        } else {
            searching = false
            self.tableView.reloadData();
            searchButton.setImage(searchImage, for: .normal)
        }
        
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: self.tableView)
        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.tableView)

    }
    
//   public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
//        //input text
//       let searchText  = textField.text! + string
//        //add matching text to arrays
//        searchNamesArrRes = namesArr.filter { $0.range(of: searchText, options: .caseInsensitive) != nil }
//    
//        searching = true
//        self.tableView.reloadData();
//    
//        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: self.tableView)
//        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.tableView)
//    
//        return true
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        if( searching == true){
            return searchNamesArrRes.count
        }else{
            return namesArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocTable_TableCell", for: indexPath) as! LocTable_TableCell
        
        
        //check search text & original text
        if( searching == true){
            let mylabel = searchNamesArrRes[indexPath.row]
            //cell.textLabel?.text = mylabel
            cell.label.text = mylabel
        }else{
            let mylabel = namesArr[indexPath.row]
            //cell.textLabel?.text = mylabel
            cell.label.text = mylabel
        }
        
        /*
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        */
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let title = tableView.cellForRow(at: indexPath as IndexPath)?.textLabel?.text
        var title = ""
        if( searching == true){
            title = searchNamesArrRes[indexPath.row]
        }else{
            title = namesArr[indexPath.row]
        }
    
        print("title: ", title)
        mySelection = title
        backWithData = true        
        
        for location in viewModel?.locationsModel.items ?? []{
            if(location?.name == title){
                let id : String = String(location?.id ?? 0)
                //var installation = PreferencesUtil.shared.installation
                PreferencesUtil.shared.installation = id
            }
        
        }

        /*
        // get our selected location
        var location = viewModel?.locationsModel.items?[indexPath.row]
        var id : String = String(location?.id ?? 0)
        var installation = PreferencesUtil.shared.installation
        */
        performSegue(withIdentifier: "unwindSegue", sender: title)
    }

    
    
}

