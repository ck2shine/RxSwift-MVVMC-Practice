//
//  TrainListCoordinator.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainListCoordinator : Coordinator<UINavigationController> , CoordinatorDependancy{
    
    var dependency: DataObjectDependancy?//
    private var trainListVC : TrainListViewController? //
    private let trainList : [TrainShowData]//
    
    init(navigator : UINavigationController , trainStoreObj : TrainStoreObj) {
        self.dependency = trainStoreObj
        self.trainList = trainStoreObj.trainList
        super.init(viewController: navigator)
    }
    
    override func start() {
        let trainListViewController = TrainListViewController()
        trainListViewController.trainList = self.trainList
        self.presenter?.pushViewController(trainListViewController, animated: true)
    }
    
}
