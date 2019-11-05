//
//  Coordinator.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/11/4.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit
class Coordinator<T: UIViewController> : CoordinateProtocol {

    var presenter : T?

    func stop() {

    }

    func start() {

    }
    
   init(viewController : T?) {
        self.presenter = viewController
    }

    deinit {
        print(" this Coordinate \(String(describing: self)) deinit ")
    }
}
