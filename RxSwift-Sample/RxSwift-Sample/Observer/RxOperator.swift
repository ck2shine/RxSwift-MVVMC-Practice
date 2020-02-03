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
        let temperature  = PublishSubject<Double>()
        temperature.filter { (temp) -> Bool in
            return temp > 20
        }.subscribe(onNext: { (temp) in
            print("temperature is over 20 !! it`s \(temp) ")
            }).disposed(by: disposeBag)

        temperature.onNext(15)
        print("nothing before 20")
        temperature.onNext(30)

        //map
        Observable.of(1,2,3).map { (num) -> Bool in
            return num > 2
        }.subscribe(onNext: { (isOver) in
            if isOver {
                 print("there is a num over 2 in seqense")
            }

            })
            .disposed(by: disposeBag)

        //zip
        let date = PublishSubject<Int>()


        let name = PublishSubject<String>()

        Observable.zip(date, name).filter({ $0 == 10 && $1 == "Jack" }).subscribe(onNext: { (date, name) in
            print("日期 : \(date) , 人名 : \(name)")
            }).disposed(by: disposeBag)
        date.onNext(10)
        name.onNext("Jack")

    }



}
