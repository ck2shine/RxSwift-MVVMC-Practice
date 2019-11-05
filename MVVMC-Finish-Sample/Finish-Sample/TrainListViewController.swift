//
//  TrainList.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainListViewController: UIViewController {
    
    weak var delegate : TrainListViewControllerDelegate?
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutViews()
        
        if !isFromFirstStackTrainList
        {
            //self.LogoutButton.isEnabled = false
            //self.LogoutButton.tintColor = .clear
        }
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
        return self.trainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "trainListCell"){
            cell = dequeueCell
        }else{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "trainListCell")
        }
        let trainInfo = self.trainList[indexPath.row]
        cell.textLabel?.text =  trainInfo.mainTitle
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = trainInfo.subTitle
        cell.accessoryType =  cellAccessoryType // from setting
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard isFromFirstStackTrainList else {
            return
        }
        let trainInfoData = self.trainList[indexPath.row];
        self.performSegue(withIdentifier: "toTrainDetail", sender: trainInfoData)
    }
    
}

extension TrainListViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? TrainDetailViewController , let trainInfoData = sender as? TrainInfo{
            detailVC.trainInfoData = trainInfoData
        }
        
    }
}


