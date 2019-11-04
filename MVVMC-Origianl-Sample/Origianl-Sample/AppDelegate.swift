//
//  AppDelegate.swift
//  Origianl-Sample
//
//  Created by i9400503 on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        self.replaceToViewControllers(.SignIn)
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

extension AppDelegate{
    
    enum rootType {
        case SignIn , TrainList
    }
    
    func replaceToViewControllers( _ type : rootType){      
        switch type {
        case .SignIn:
            let signInVC = UIStoryboard(name: "LoginViewStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PreloadViewController")
            window?.rootViewController = signInVC
        case .TrainList:
            let trainList = UIStoryboard(name: "TrainViewStoryboard", bundle: nil).instantiateViewController(withIdentifier: "trainNavigationVC")
            window?.rootViewController = trainList
        }
        
    }
}

