//
//  TestViewModel.swift
//  RxSwift-Sample
//
//  Created by i9400503 on 2020/2/13.
//  Copyright © 2020 Brille. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class TestViewModel{
    var nameField : BehaviorRelay<String?>?

    var publishNameField : PublishRelay<String?>?

    init(){

        publishNameField = PublishRelay<String?>()
        publishNameField?.skip(1).subscribe(onNext: { (str) in
                   print("change text : \(str)")
               })
//        publishNameField.subscribe(onNext: { (str) in
//            print("by use ing publish")
//        })
//        nameField.subscribe(onNext: { (str) in
//             print("save DB :\(str ?? "ccc")")
//        })
    }

    func setupBinding(_ value : String){
        nameField = BehaviorRelay<String?>(value: value)
        nameField?.skip(1).subscribe(onNext: { (str) in
            self.saveDB(str!)
        })
        nameField?.subscribe(onNext: { (str) in
               self.validLabel()
           })
    }

    func saveDB(_ changeValue : String){
        print("save DB \(changeValue)")
    }

    func validLabel(){
        print("valid label")
    }
}
