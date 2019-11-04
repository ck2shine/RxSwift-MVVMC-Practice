//
//  TrainListCoordinator.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainListCoordinator : Coordinator<UIViewController> , CoordinatorDependancy{
    
    var dependency: DataObjectDependancy?//
    private let navigator : UINavigationController //
    private var trainListVC : TrainListViewController? //
    private let trainList : [TrainShowData]//
    
    init(navigator : UINavigationController , trainStoreObj : TrainStoreObj) {
        self.navigator = navigator
        self.dependency = trainStoreObj
        self.trainList = trainStoreObj.trainList
    }
    
    override func start() {
        
    }
    
}
