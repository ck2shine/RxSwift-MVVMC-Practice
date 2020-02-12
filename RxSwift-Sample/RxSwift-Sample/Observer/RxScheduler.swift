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

    func withGCD(){
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = Bundle.main.url(forResource: "dept", withExtension: ".json") ,
                let _ = try?  Data(contentsOf: url){
                let _ = JSONDecoder()
            }
            
            DispatchQueue.main.async {
                //do some UI
                self.InputTextField.text = "Test123"
            }
        }
        
    }
    
    func buildAScheduler(){

        self.scheduleObservable = Observable<String>.create { (observe) -> Disposable in

            if let url = Bundle.main.url(forResource: "dept", withExtension: ".json") ,
                let _ = try?  Data(contentsOf: url){
                let _ = JSONDecoder()

            }

            observe.onNext("done")
            observe.onCompleted()
            return Disposables.create()

        }
        //1..global
        self.scheduleObservable?
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance) //2..main
            .subscribe(onNext: {  [unowned self] str in
                self.InputTextField.text = "Test123"
            })
            .disposed(by: disposeBag)
        
    }

}
