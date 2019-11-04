//
//  LoginViewcontroller.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/11/3.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class LoginViewcontroller: UIViewController  , UIViewControllerTransitioningDelegate{
    @IBOutlet weak var TopView: UIView!

    @IBOutlet weak var BottonView: UIView!
  
   // private var transitionCordinator = LoginAnimation()


    @IBAction func SignInAction(_ sender: Any) {
        self.dismiss(animated: true){
            let appDelegate =  UIApplication.shared.delegate as! AppDelegate
            appDelegate.replaceToViewControllers(.TrainList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    deinit {
        print("SignIn release")
    }


}

