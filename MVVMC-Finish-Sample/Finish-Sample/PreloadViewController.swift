//
//  PreloadViewController.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/11/4.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit


class PreloadViewController: UIViewController  {

    var isAlreadyLoadLogin = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !isAlreadyLoadLogin{
            let signInVC = UIStoryboard(name: "LoginViewStoryboard", bundle: nil).instantiateViewController(withIdentifier: "LoginViewStoryboard")
            signInVC.transitioningDelegate = self
            self.present(signInVC, animated: true, completion: nil)
            isAlreadyLoadLogin = true
        }
    }

}

extension PreloadViewController : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return LoginPresentAnimation()

    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return LoginDissAnimation()
    }
}
