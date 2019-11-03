//
//  LoginViewcontroller.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/11/3.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class LoginViewcontroller: UIViewController {
    
    @IBAction func SignInAction(_ sender: Any) {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        appDelegate.replaceToViewControllers(.TrainList)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("SignIn release")
    }
}
