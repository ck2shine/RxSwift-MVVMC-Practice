//
//  RxObserver.swift
//  RxSwift-Sample
//
//  Created by i9400503 on 2020/1/9.
//  Copyright © 2020 Brille. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
/*
 TestButton
 InputValidLabel
 InputTextField
 */
extension ViewController {
    func RxObserver_eventSubscrite(){
        eventNormal()
        eventAnyObserver()
    }
}
extension ViewController{
    final private func eventNormal(){
        //..1
        let tapObservable = TestButton.rx.tap

        //..2
        tapObservable.subscribe(onNext: { [weak self] _ in

        }, onError: {error in

        }, onCompleted: {

        })
    }

    final private func eventAnyObserver(){
        let observer : AnyObserver<Data> = AnyObserver { (event) in
            switch event{
            case .next(let data):
                print("session task success \(data)")
            case .error(let error):
                print("session task error \(error)")
            default :
                break
            }
        }
        //..1 make a observer
        URLSession.shared.rx.data(request: URLRequest(url: URL(string: "http://test.com.tw")!))
            .subscribe(observer)
            .disposed(by: disposeBag)

//        let labelObserver : AnyObserver<Bool> = AnyObserver {[weak self] (event) in
//            guard let self = self else {return}
//            switch event{
//            case .next(let isHidden) :
//                self.InputValidLabel.isHidden = isHidden
//            default :
//                break
//            }
//        }
//        InputTextField.rx.text.map { $0?.count ?? 0  > 0}
//            .subscribe(labelObserver)
//            .disposed(by: disposeBag)


        InputTextField.rx.text.map { $0?.count ?? 0  > 0}.bind(to:  self.InputValidLabel.rx.isHidden).disposed(by: disposeBag)
        
    }
}
