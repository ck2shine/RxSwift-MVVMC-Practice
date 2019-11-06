//
//  TrainDetailCoordinator.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainDetailCoordinator: Coordinator<UINavigationController> , CoordinatorDependancy {
    var dependency: LoadingDataDependancy?
    
    private var selectedTrainInfo :TrainInfo?
    private(set) var trainDetailViewController : TrainDetailViewController?
    private var timeTableCoordinator : TimeTableCoordinator?
    
    init(viewController: UINavigationController? , loadDataObj : LoadingDataDependancy , selectedTrainInfo : TrainInfo) {
        self.dependency = loadDataObj
        self.selectedTrainInfo = selectedTrainInfo
        super.init(viewController: viewController)
    }
    
    
    override func start() {
        let trainDetailVC = TrainDetailViewController.fromStoryboard() as! TrainDetailViewController
        trainDetailVC.trainInfoData = self.selectedTrainInfo 
        trainDetailVC.delegate = self
        self.presenter?.pushViewController(trainDetailVC, animated: true)
        self.trainDetailViewController = trainDetailVC
    }
}

extension TrainDetailCoordinator:TrainDetailViewControllerDelegate{
    func didSelectTrainNoForTimeTable(_ trainNo: String) {
        //method 1
        
        self.dependency?.trainObjForDetail.params?.trainNo = trainNo
        let viewModel = TrainListViewModel(trainStoreObj: self.dependency?.trainObjForDetail)
        let timeTableViewController = TrainListViewController(viewModel: viewModel)
        timeTableViewController.title = "TimeTable"
        self.presenter?.pushViewController(timeTableViewController, animated: true)
        /*
         //method2
         self.dependency?.trainObjForDetail.params?.trainNo = trainNo
         
         let timeTableCoordinator = TimeTableCoordinator(viewController: self.presenter, loadDataObj: self.dependency!)
         
         timeTableCoordinator.start()
         self.timeTableCoordinator = timeTableCoordinator
         */
    }
    
    
}
