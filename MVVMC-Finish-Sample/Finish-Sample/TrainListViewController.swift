//
//  TrainList.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainListViewController: UIViewController {
    @IBOutlet weak var LogoutButton: UIBarButtonItem!
    @IBAction func LogOutAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.replaceToViewControllers(.SignIn)
    }
    
    @IBOutlet weak var dataList: UITableView!

    var isFromFirstStackTrainList : Bool = true

    var trainList : [TrainShowData] = TrainStoreObj.shared.trainList {
        didSet{
            self.dataList?.reloadData()
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
        
        if !isFromFirstStackTrainList
        {
            self.LogoutButton.isEnabled = false
            self.LogoutButton.tintColor = .clear
        }
        
       
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
        cell.accessoryType =  isFromFirstStackTrainList ? .disclosureIndicator : .none
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


