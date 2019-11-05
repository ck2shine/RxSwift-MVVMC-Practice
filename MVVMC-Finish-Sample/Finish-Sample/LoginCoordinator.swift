//
//  LoginCoordinator.swift
//  Finish-Sample
//
//  Created by i9400503 on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class LoginCoordinator : Coordinator<UINavigationController>{


    override func start() {
        let loginViewController = LoginViewcontroller.fromStoryboard("LoginViewStoryboard") as! LoginViewcontroller
        if let presenter = presenter?.viewControllers.first as? PreloadViewController {
            loginViewController.transitioningDelegate = presenter
        }
        loginViewController.delegate = self

        presenter?.present(loginViewController, animated: true)
    }
}


extension LoginCoordinator : LoginViewControllerDelegat{
    func reDirectToTrainList() {
        self.presenter?.dismiss(animated: true){
            let appDelegate =  UIApplication.shared.delegate as! AppDelegate
            appDelegate.replaceToViewControllers(.TrainList)
        }
    }
}
