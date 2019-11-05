//
//  PreloadCoordinator.swift
//  Finish-Sample
//
//  Created by i9400503 on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class PreloadCoordinator : Coordinator<UINavigationController>{

    private var loginCoordinator : LoginCoordinator?

    override init(viewController: UINavigationController?) {
        super.init(viewController: viewController)
    }

    override func start() {
         let preloadVC = PreloadViewController.fromStoryboard() as! PreloadViewController
         preloadVC.delegate = self
        self.presenter?.pushViewController(preloadVC, animated: true)
        super.start()
    }
}

extension PreloadCoordinator : ProloadViewControllerDelegate{
    func startAnimatingLoginView() {
        let loginCoordinator = LoginCoordinator(viewController: presenter)
        loginCoordinator.start()
        self.loginCoordinator = loginCoordinator

    }
}
