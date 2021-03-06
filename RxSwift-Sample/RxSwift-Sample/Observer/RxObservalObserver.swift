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

        //asyncObject()

        //publishSubject()

        //replaySubject()

        behaviorSubject()
    }
}

extension ViewController{


    final private func observableAndObserver(){
        //as observable
//        let observable = InputTextField.rx.text
//        observable.subscribe(onNext: { (text) in
//            print(text ?? "")
//        }).disposed(by: disposeBag)

        //1..as observer
        let observer = InputTextField.rx.text
     
        let text : Observable<String> = Observable.create { observe in
            observe.onNext("success")
            return Disposables.create()
        }
        text.bind(to: observer).disposed(by: disposeBag)
        
        //2.. as observable
        InputTextField.rx.text.subscribe(onNext: { str in
            print("each change str : \(str ?? "")")
        })
        .disposed(by: disposeBag)
        
        
        
    }

    final private func asyncObject(){
        
        let subject = AsyncSubject<String>()
        subject.asObservable().subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        subject.onNext("😝")
        subject.onNext("😫")
        subject.onNext("🥵")
        subject.onCompleted()
        
        
    }

    final private func publishSubject(){

        //as observable
        let subject = PublishSubject<String>()
        subject.asObservable().subscribe { print("this is first \($0)") }
        .disposed(by: disposeBag)

        subject.onNext("ccc")
        subject.onNext("aaaa")

        subject.subscribe{print("this is second \($0)")}
            .disposed(by: disposeBag)
        subject.onNext("bbbb")
        subject.onNext("ddddd")
        
        
    }

    final private func replaySubject(){
        
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        subject.asObservable()
            .subscribe { print("this is first \($0)") }
            .disposed(by: disposeBag)

        subject.onNext("aaaa")
        subject.onNext("bbbb")
        subject.subscribe{print("this is second \($0)")}.disposed(by: disposeBag)
        subject.onNext("cccc")
        subject.onNext("dddd")
        
    }

    final private func behaviorSubject(){
        
        let subject = BehaviorSubject(value: "default")
        subject.asObservable()
            .subscribe { print("this is first \($0)") }
            .disposed(by: disposeBag)

        subject.onNext("aaaa")
        subject.onNext("bbb")
        subject.subscribe{print("this is second \($0)")}.disposed(by: disposeBag)
        subject.onNext("cccc")
        
        
    }
}
