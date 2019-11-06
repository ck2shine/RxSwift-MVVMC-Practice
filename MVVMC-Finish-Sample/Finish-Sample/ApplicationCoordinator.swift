//
//  ApplicationCoordinator.swift
//  Origianl-Sample
//
//  Created by i9400503 on 2019/11/4.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

enum rootType {
    case SignIn , TrainList
}

class ApplicationCoordinator: Coordinator<UIViewController>{
    
    private let dataObjectDependancy = LoadingDataDependancy()
    private var preloadViewController : PreloadViewController?
    private var nextCoordinator : Coordinator<UINavigationController>? // keep reference
    var window : UIWindow?

    var coordinatorType : rootType

    init(window : UIWindow) {
        self.window = window
        self.coordinatorType = .SignIn
        super.init(viewController: nil)
    }

    override func start() {
        let navigator = UINavigationController()
        switch coordinatorType {
        case .SignIn:
            navigator.isToolbarHidden = true
            let coordinator = PreloadCoordinator(viewController: navigator)
            nextCoordinator = coordinator
           
        case .TrainList:

            navigator.navigationBar.prefersLargeTitles = true
            let  coordinator = TrainListCoordinator(navigator: navigator, loadDataObj: dataObjectDependancy)
            nextCoordinator = coordinator
        }
        window?.rootViewController = nextCoordinator?.presenter
        nextCoordinator?.start()
        super.start()
    }
}
