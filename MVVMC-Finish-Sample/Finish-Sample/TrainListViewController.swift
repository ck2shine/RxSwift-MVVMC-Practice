//
//  TrainList.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainListViewController : UIViewController {
    
    weak var delegate : TrainListViewControllerDelegate?
    
    var controller : TrainListController
    
    var viewModel : TrainListViewModel{
        return controller.viewModel
    }
    
    init(viewModel : TrainListViewModel) {
        self.controller = TrainListController(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //@IBOutlet weak var LogoutButton: UIBarButtonItem! //TODO delete
    //    @IBAction func LogOutAction(_ sender: Any) {
    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //        appDelegate.replaceToViewControllers(.SignIn)
    //    }
    
    //@IBOutlet weak var dataList: UITableView!//use coding
    
    private lazy var dataTable : UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private lazy var loadActivity:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        return activity
    }()
    
    private lazy var logoutBarItem: UIBarButtonItem = {
        let logoutItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(LogoutAction(_:)))
        return logoutItem
    }()
    
    //var isFromFirstStackTrainList : Bool = true // no need this variable       
    
    //we can delete data
    /*
     
     
     
     var trainList : [TrainShowData] = [] { //not form share instance
     didSet{
     self.dataTable.reloadData()// cancel optional Outlet
     }
     }
     
     var trainNo : String?{
     didSet
     {
     
     guard let trainNo = trainNo else {return }
     trainList = TrainStoreObj.shared.trainTimeTable[trainNo] ?? []
     title = "TimeTable : \(trainNo)"
     }
     }
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutViews()
        
        dataBinding()
        
        //        if !isFromFirstStackTrainList TODO delete part
        //        {
        //            //self.LogoutButton.isEnabled = false
        //            //self.LogoutButton.tintColor = .clear
        //        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controller.refreshTableData()
    }
    
    deinit {
        print("TrainList VC has released")
    }
}

extension TrainListViewController{
    final private func dataBinding(){
        let outputs = viewModel.outputs
        
        outputs.dataList.binding(trigger: false, listener: {[unowned self] (dataList) in
            self.dataTable.reloadData()
        })
        
        outputs.addBarItem.binding(listener: {[unowned self] (itemMode) in
            if let itemMode = itemMode  {
                
                switch itemMode {
                case .activity:
                    self.navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: self.loadActivity)
                case .both:
                    self.navigationItem.rightBarButtonItems = [ self.logoutBarItem,UIBarButtonItem(customView: self.loadActivity)]
                default:
                    self.navigationItem.rightBarButtonItem =  self.logoutBarItem
                }
            }
        })
        
        outputs.isLoading.binding( listener: {[unowned self] (loading) in
            
            if let loading = loading , loading{
                self.loadActivity.startAnimating()
            }
            else
            {
                self.loadActivity.stopAnimating()
            }
        })
        
        outputs.logout.binding(trigger: false, listener: { (logout) in
            if let logout = logout , logout{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.replaceToViewControllers(.SignIn)
            }
        })
    }
}

extension TrainListViewController{
    final private func layoutViews(){
        //table
        dataTable.backgroundColor = .white
        view.addSubview(dataTable)
        dataTable.translatesAutoresizingMaskIntoConstraints = false
        dataTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dataTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dataTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dataTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        dataTable.delegate = self
        dataTable.dataSource = self
        
        
        //        let indicatorItem = UIBarButtonItem(customView: loadActivity)
        //        print(navigationItem.leftBarButtonItem)
        //         print(navigationItem.leftBarButtonItems)
        //        //navigationItem.rightBarButtonItems?.append(indicatorItem)
        
        //        view.addSubview(loadActivity)
        //        view.bringSubviewToFront(loadActivity)
        //        loadActivity.translatesAutoresizingMaskIntoConstraints = false
        //        loadActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        loadActivity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }
}

extension TrainListViewController{
    @objc func LogoutAction(_ sender : UIBarButtonItem){
        self.controller.logout()
    }
}

extension TrainListViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : TrainListViewCell
        
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "trainListCell") as? TrainListViewCell{
            cell = dequeueCell
        }else{
            cell = TrainListViewCell(style: .subtitle, reuseIdentifier: "trainListCell")
        }
        
        if let viewModel = self.viewModel.dataList.value?[indexPath.row] {
            cell.setupCell(viewModel: viewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        guard isFromFirstStackTrainList else { TODO delete part
        //            return
        //        }
        
        //change to delegate to call coordinator TODO delete part
        if let viewModel = self.viewModel.originalData?[indexPath.row] as? TrainInfo{
            self.delegate?.didSelectTrainDetail(viewModel)
        }
        
        //        let trainInfoData = self.trainList[indexPath.row];
        //        self.performSegue(withIdentifier: "toTrainDetail", sender: trainInfoData)
    }
    
}

//TODO delete this part
//extension TrainListViewController{
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let detailVC = segue.destination as? TrainDetailViewController , let trainInfoData = sender as? TrainInfo{
//            detailVC.trainInfoData = trainInfoData
//        }
//
//    }
//}


