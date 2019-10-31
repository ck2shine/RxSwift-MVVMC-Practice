//
//  TrainList.swift
//  Origianl-Sample
//
//  Created by i9400503 on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainListViewController: UIViewController {

    @IBOutlet weak var dataList: UITableView!

    var isFromFirstStackTrainList : Bool = true

    var trainList : [TrainShowData] = TrainStoreObj.shared.trainList {
        didSet{
            self.dataList.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        let TrainNo = self.trainList[indexPath.row];
        self.performSegue(withIdentifier: "toTrainDetail", sender: TrainNo)
    }
    
}

extension TrainListViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? TrainDetailViewController , let TrainNo = sender as? String{
            detailVC.TrainNo = TrainNo
        }
        
    }
}


