//
//  TimeTableCoordinator.swift
//  Finish-Sample
//
//  Created by i9400503 on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TimeTableCoordinator: Coordinator<UINavigationController> , CoordinatorDependancy {
    var dependency: LoadingDataDependancy?
    private var timeTableViewController : TrainListViewController?

    init(viewController: UINavigationController? ,
         loadDataObj : LoadingDataDependancy) {
        self.dependency = loadDataObj
        super.init(viewController: viewController)
    }

    override func start() {
        let viewModel = TrainListViewModel(trainStoreObj: self.dependency?.trainObjForDetail)
        let timeTableViewController = TrainListViewController(viewModel: viewModel)
        timeTableViewController.cellAccessoryType = .none
        timeTableViewController.title = "TimeTable"
        self.presenter?.pushViewController(timeTableViewController, animated: true)

    }

}
