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

    var trainList : [TrainInfo] = TrainStoreObj.shared.trainList {
        didSet{
            self.dataList.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension TrainListViewController : UITableViewDataSource {
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
        cell.textLabel?.text = trainInfo.Train
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = isFromFirstStackTrainList ? trainInfo.Note
        cell.accessoryType =  isFromFirstStackTrainList ? .disclosureIndicator : .none
        return cell
    }


}
