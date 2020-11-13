//  ML_Guides_TableView.swift

import UIKit

//@IBDesignable
class ML_Guides_TableView: UIView {
    
    var viewModel : GuidesViewModel?
    let tableDataSource = ML_Guides_TableDataSource()
    //let flowLayout = ML_Guides_TableFlowLayout()

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        //let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(for: ML_Guides_TableView.self)
        bundle.loadNibNamed("ML_Guides_TableView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        //contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.layer.masksToBounds = false
        
        initTableView()
        
       
        
        
    }
    
    private func initTableView() {
        //tableView.register(UINib(nibName: "LT_TableViewCell", bundle: nil), forCellReuseIdentifier: "ALCell")
        
        let nib = UINib(nibName: "ML_Guides_TableCell", bundle: nil)
        //tableView.register(nib, forCellWithReuseIdentifier: "ML_Guides_TableCell")
        tableView.register(nib, forCellReuseIdentifier: "ML_Guides_TableCell")
        //tableView.accessibilityIdentifier = "ml_tableview_id"
        //tableView.accessibilityLabel = "ml_tableview_label"


         
        tableDataSource.viewModel = self.viewModel

        //tableView.dataSource = self
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDataSource
    }
}
