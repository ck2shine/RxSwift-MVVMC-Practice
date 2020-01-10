//
//  RxObservalObserver.swift
//  RxSwift-Sample
//
//  Created by i9400503 on 2020/1/10.
//  Copyright © 2020 Brille. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
extension ViewController{
    func RxObservalAndObserver(){
        observableAndObserver()

        asyncObject()
    }
}

extension ViewController{


    final private func observableAndObserver(){
        //as observable
        let observable = InputTextField.rx.text
        observable.subscribe(onNext: { (text) in
            print(text ?? "")
        }).disposed(by: disposeBag)

        //as observer
        let observer = InputTextField.rx.text
        let text : Observable<String> = Observable.create { (observe) -> Disposable in
            observe.onNext("success")
            return Disposables.create()
        }
        text.bind(to: observer).disposed(by: disposeBag)
    }

    final private func asyncObject(){
        let subject = AsyncSubject<String>()
        subject.subscribe(onNext: <#T##((String) -> Void)?##((String) -> Void)?##(String) -> Void#>, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
}
