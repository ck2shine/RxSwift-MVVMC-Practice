//
//  LoginAnimation.swift
//  Origianl-Sample
//
//  Created by i9400503 on 2019/11/4.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit
class LoginPresentAnimation :NSObject, UIViewControllerAnimatedTransitioning{

    var durationTime = 1.0

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTime
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let contentView = transitionContext.containerView

        let loginVC : LoginViewcontroller = transitionContext.viewController(forKey: .to) as! LoginViewcontroller


        contentView.addSubview(loginVC.view)

        var topStartFrame = loginVC.TopView.frame
        var topEndFrame = loginVC.TopView.frame
        var bottomStartFrame = loginVC.BottonView.frame
        var bottomEndFrame = loginVC.BottonView.frame


        topStartFrame.origin.y = -topStartFrame.height
        topEndFrame.origin.y = 0
        bottomStartFrame.origin.y = contentView.frame.height
        bottomEndFrame.origin.y = contentView.frame.height - bottomStartFrame.height

        //position the frame
        loginVC.TopView.frame = topStartFrame
        loginVC.BottonView.frame = bottomStartFrame

        UIView.animate(withDuration: durationTime, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: [], animations: {
            loginVC.TopView.frame = topEndFrame
            loginVC.BottonView.frame = bottomEndFrame
        }) { (complete) in
            transitionContext.completeTransition(complete)
        }
    }
}

class LoginDissAnimation :NSObject, UIViewControllerAnimatedTransitioning{
    var durationTime = 1.0

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTime
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let contentView = transitionContext.containerView

        let toVC  = transitionContext.viewController(forKey: .to)
        let loginVC : LoginViewcontroller = transitionContext.viewController(forKey: .from) as! LoginViewcontroller

        contentView.addSubview(toVC!.view)
        contentView.bringSubviewToFront(loginVC.view)
        var topStartFrame = loginVC.TopView.frame
        var topEndFrame = loginVC.TopView.frame
        var bottomStartFrame = loginVC.BottonView.frame
        var bottomEndFrame = loginVC.BottonView.frame

        topStartFrame.origin.y = 0
        topEndFrame.origin.y = -topStartFrame.height
        bottomStartFrame.origin.y = contentView.frame.height - bottomStartFrame.height
        bottomEndFrame.origin.y = contentView.frame.height

        UIView.animate(withDuration: durationTime, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: [], animations: {
            loginVC.TopView.frame = topEndFrame
            loginVC.BottonView.frame = bottomEndFrame
        }) { (complete) in
            transitionContext.completeTransition(true)
        }
    }
}

