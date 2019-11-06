//
//  TrainListCoordinator.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainListCoordinator : Coordinator<UINavigationController> , CoordinatorDependancy{

    var dependency: LoadingDataDependancy?

    private var trainListVC : TrainListViewController? //
    //private let trainList : [TrainShowData]// gone
    private var trainDetailCoordinator : TrainDetailCoordinator?
    private(set) var trainListViewController:TrainListViewController?
    
    init(navigator : UINavigationController , loadDataObj : LoadingDataDependancy) {
        self.dependency = loadDataObj
       // self.trainList = trainStoreObj.trainList
        super.init(viewController: navigator)
    }
    
    override func start() {
        let viewModel = TrainListViewModel(trainStoreObj: self.dependency!.trainObj)

        let trainListViewController = TrainListViewController(viewModel: viewModel)
        trainListViewController.delegate = self
        self.presenter?.pushViewController(trainListViewController, animated: true)
        self.trainListViewController = trainListViewController
    }
    
}

extension TrainListCoordinator : TrainListViewControllerDelegate{
    func didSelectTrainDetail(_ selectedTrainInfo: TrainInfo) {

        let trainDetailCoordinator =  TrainDetailCoordinator(viewController: self.presenter , loadDataObj: self.dependency!, selectedTrainInfo: selectedTrainInfo)

        trainDetailCoordinator.start()
        self.trainDetailCoordinator = trainDetailCoordinator
    }
    
    
}
