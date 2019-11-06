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
    

    var viewModel : TrainListViewModel

   init(viewModel : TrainListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //@IBOutlet weak var LogoutButton: UIBarButtonItem! //gone
    @IBAction func LogOutAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.replaceToViewControllers(.SignIn)
    }
    
    //@IBOutlet weak var dataList: UITableView!//use coding
    
    private lazy var dataTable : UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private lazy var logoutBarItem: UIBarButtonItem = {
        let logoutItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(LogoutAction(_:)))
        return logoutItem
    }()

    var isFromFirstStackTrainList : Bool = true // no need this variable
    
    var cellAccessoryType = UITableViewCell.AccessoryType.disclosureIndicator

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
        
        if !isFromFirstStackTrainList
        {
            //self.LogoutButton.isEnabled = false
            //self.LogoutButton.tintColor = .clear
        }
        dataBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.refreshTableData()
    }
}

extension TrainListViewController{
    final private func dataBinding(){
        self.viewModel.dataList.binding(trigger: false, listener: {[unowned self] (dataList) in
            self.dataTable.reloadData()
        })
    }
}

extension TrainListViewController{
    final private func layoutViews(){
        title = "TrainList"
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
        
        //baritme
        navigationItem.rightBarButtonItem = logoutBarItem
    }
}

extension TrainListViewController{
    @objc func LogoutAction(_ sender : UIBarButtonItem){
        print("log out")
    }
}

extension TrainListViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "trainListCell"){
            cell = dequeueCell
        }else{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "trainListCell")
        }

        if let viewModel = self.viewModel.dataList.value?[indexPath.row] {
            cell.textLabel?.text =  viewModel.mainTitle
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.text = viewModel.subTitle
            cell.accessoryType =  cellAccessoryType // from setting
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard isFromFirstStackTrainList else {
            return
        }

        //change to delegate to call coordinator TODO
        if let viewModel = self.viewModel.dataList.value?[indexPath.row] as? TrainInfo{
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


