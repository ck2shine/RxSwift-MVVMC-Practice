//
//  AppDelegate.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var applicationCoordinator : ApplicationCoordinator?
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

       let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.applicationCoordinator = ApplicationCoordinator(window: window)
        self.window?.makeKeyAndVisible()
        self.applicationCoordinator?.start()

        return true
    }
    
}

extension AppDelegate{
    
    func replaceToViewControllers( _ type : rootType){
        applicationCoordinator?.coordinatorType = type
        applicationCoordinator?.start()        
    }
}

