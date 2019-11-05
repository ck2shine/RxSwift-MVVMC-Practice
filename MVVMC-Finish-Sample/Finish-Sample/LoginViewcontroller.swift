//
//  LoginViewcontroller.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/11/3.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class LoginViewcontroller: UIViewController  , UIViewControllerTransitioningDelegate{

    weak var delegate : LoginViewControllerDelegat?

    @IBOutlet weak var TopView: UIView!

    @IBOutlet weak var BottonView: UIView!
  
   // private var transitionCordinator = LoginAnimation()


    @IBAction func SignInAction(_ sender: Any) {
        self.delegate?.reDirectToTrainList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    deinit {
        print("SignIn release")
    }


}

