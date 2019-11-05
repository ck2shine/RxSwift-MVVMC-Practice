//
//  TrainDetailCoordinator.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainDetailCoordinator: Coordinator<UINavigationController> , CoordinatorDependancy {
    var dependency: DataObjectDependancy?
    private var selectedTrainInfo :TrainShowData?
    private(set) var trainDetailViewController : TrainDetailViewController?
    
    init(viewController: UINavigationController? , trainStoreObj : TrainStoreObj , selectedTrainInfo : TrainShowData) {
        self.dependency = trainStoreObj
        self.selectedTrainInfo = selectedTrainInfo
        super.init(viewController: viewController)
    }
    
    
    override func start() {
        let trainDetailVC = TrainDetailViewController.fromStoryboard() as! TrainDetailViewController
        trainDetailVC.trainInfoData = self.selectedTrainInfo as? TrainInfo
        self.trainDetailViewController = trainDetailVC
    }
}
