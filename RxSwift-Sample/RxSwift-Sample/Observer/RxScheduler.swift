//
//  RxScheduler.swift
//  RxSwift-Sample
//
//  Created by i9400503 on 2020/2/3.
//  Copyright © 2020 Brille. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
extension ViewController{

    func RxScheduler(){

        buildAScheduler()
    }

}


extension ViewController{

    func buildAScheduler(){

        self.scheduleObservable = Observable<String>.create { (observe) -> Disposable in

            if let url = Bundle.main.url(forResource: "dept", withExtension: ".json") , let data = try?  Data(contentsOf: url){
                let decoder = JSONDecoder()

            }

            observe.onNext("done")
            observe.onCompleted()
            return Disposables.create()


        }
    }

}
