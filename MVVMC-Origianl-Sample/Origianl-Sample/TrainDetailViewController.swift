//
//  TrainDetailViewController.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainDetailViewController: UITableViewController {
    
    @IBOutlet weak var TrainNoLabel: UILabel!
    
    @IBOutlet weak var carClassLabel: UILabel!
    @IBOutlet weak var BikeLabel: UILabel!
    @IBOutlet weak var BreastFeedLabel: UILabel!
    @IBOutlet weak var CrippleCarLabel: UILabel!
    var trainInfoData : TrainInfo?{
        didSet
        {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.showDataToView()
    }
    
}

extension TrainDetailViewController  {
        
    func showDataToView(){
        self.TrainNoLabel.text = trainInfoData?.Train
        self.carClassLabel.text = trainInfoData?.CarClass
        self.BikeLabel.text = trainInfoData?.Bike == "Y" ? "Yes" : "No"
        self.BreastFeedLabel.text = trainInfoData?.BreastFeed == "Y" ? "Yes" : "No"
        self.CrippleCarLabel.text = trainInfoData?.Cripple == "Y" ? "Yes" : "No"
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section == tableView.numberOfSections - 1  else { return}
        self.performSegue(withIdentifier: "toTrainList", sender: trainInfoData?.Train)
    }
}

extension TrainDetailViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toListView = segue.destination as? TrainListViewController {
            
            toListView.isFromFirstStackTrainList = false
            toListView.trainNo = sender as? String
            
        }
    }
}
