//
//  TrainListCoordinator.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainListCoordinator : Coordinator<UINavigationController> , CoordinatorDependancy{
    typealias dataInfo = TrainInfo
    
    
    var dependency: DataObjectDependancy<Any, Any>?//
    private var trainListVC : TrainListViewController? //
    private let trainList : [TrainShowData]//
    private var trainDetailCoordinator : TrainDetailCoordinator?
    private(set) var trainListViewController:TrainListViewController?
    
    init(navigator : UINavigationController , trainStoreObj : TrainStoreObj) {
        self.dependency = trainStoreObj
        self.trainList = trainStoreObj.trainList
        super.init(viewController: navigator)
    }
    
    override func start() {
        let trainListViewController = TrainListViewController()
        trainListViewController.delegate = self
        trainListViewController.trainList = self.trainList
        self.presenter?.pushViewController(trainListViewController, animated: true)
        self.trainListViewController = trainListViewController
    }
    
}

extension TrainListCoordinator : TrainListViewControllerDelegate{
    func didSelectTrainDetail(_ selectedTrainInfo: TrainShowData) {
        self.trainDetailCoordinator = TrainDetailCoordinator(viewController: self.presenter, trainStoreObj: self.dependency, selectedTrainInfo: <#T##TrainShowData#>)
    }
    
    
}
