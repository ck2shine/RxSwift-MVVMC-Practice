//
//  RxOperator.swift
//  RxSwift-Sample
//
//  Created by i9400503 on 2020/2/3.
//  Copyright © 2020 Brille. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension ViewController{
    func RxOperator(){
        sampleOfOperator()
    }
}

extension ViewController{
    final private func sampleOfOperator(){
        
        //of
        let _ = Observable<Int>.of(3,4,5)
        
        //equal to
        let _ = Observable<Int>.create { event  in
            event.onNext(3)
            event.onNext(4)
            event.onNext(5)
            event.onCompleted()
            return Disposables.create()
        }
        
        
        //from
        let _ = Observable<String>.from(["Mary" , "Lee" , "Bob"])
        
        //equal to
        let _ = Observable<String>.create { event  in
            event.onNext("Mary")
            event.onNext("Lee")
            event.onNext("Bob")
            event.onCompleted()
            return Disposables.create()
        }
        
        
        
        //Filter
        let temperature  = PublishSubject<Double>()
        temperature.filter { (temp) -> Bool in
            return temp > 20
        }.subscribe(onNext: { (temp) in
            print("temperature is over 20 !! it`s \(temp) ")
        }).disposed(by: disposeBag)
        
        temperature.onNext(15)
        print("nothing before 20")
        temperature.onNext(30)
        
        
        //just
        let _ = Observable<Int>.just(3)
        
        
        //empty
        let _ = Observable<Int>.empty()
        
        //equal to
       let _ = Observable<Int>.create { event  in
           event.onCompleted()
           return Disposables.create()
       }
        
        
        //map
        Observable.of(1,2,3).map { (num) -> Bool in
            return num > 2
        }.subscribe(onNext: { (isOver) in
            if isOver {
                print("there is a num over 2 in seqense")
            }
            
        }).disposed(by: disposeBag)
        
        
        
        //zip
        let date = PublishSubject<Int>()
        
        let name = PublishSubject<String>()
        
        Observable.zip(date, name)
            .filter({ $0 == 10 && $1 == "Jack" })
            .subscribe(onNext: { (date, name) in
            print("日期 : \(date) , 人名 : \(name)")
        }).disposed(by: disposeBag)
        date.onNext(10)
        date.onNext(20)
        name.onNext("Jack")
        
        
    }
    
    
    
}
