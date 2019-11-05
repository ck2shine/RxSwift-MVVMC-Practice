//
//  PreloadViewController.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/11/4.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit


class PreloadViewController: UIViewController  {

    weak var delegate : ProloadViewControllerDelegate?

    var isAlreadyLoadLogin = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isAlreadyLoadLogin{
            delegate?.startAnimatingLoginView()
            isAlreadyLoadLogin = true
        }
    }

    deinit {
        print("preLoad release")
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
