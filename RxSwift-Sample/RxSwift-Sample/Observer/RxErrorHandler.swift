//
//  RxErrorHandler.swift
//  RxSwift-Sample
//
//  Created by i9400503 on 2020/2/4.
//  Copyright © 2020 Brille. All rights reserved.
//

import Foundation
import RxSwift
extension ViewController{
    func RxErrorHandler(){
        //reTry()
        //        reTryWhen()
//        catchError()
        result()
    }
}


extension ViewController{

    func reTry(){
        let fetchDataObservable = Observable<Int>.create { (event) -> Disposable in

            if let url =  Bundle.main.url(forResource: "dept", withExtension: ".json") ,
                let data = try? Data(contentsOf: url){
                
            }


            print("try1")

            event.onError(DataError.cantParseJSON("jsonError"))
            event.onCompleted()


            return Disposables.create()
        }.retry(3)
            .subscribe(onNext: { (number) in
                print(" success get job")
            }, onError: { (error) in
                print(" error ")
            })

        fetchDataObservable.disposed(by: disposeBag)
    }


    func reTryWhen(){
        let fetchDataObservable = Observable<Int>.create { (event) -> Disposable in

            if let url =  Bundle.main.url(forResource: "dept", withExtension: ".json") ,
                let data = try? Data(contentsOf: url){

            }


            print("try1")

            event.onError(DataError.cantParseJSON("jsonError"))
            event.onCompleted()


            return Disposables.create()
        }
        fetchDataObservable.retryWhen { (rxError) -> Observable<Int> in
            return rxError.enumerated().flatMap { (idx, error) ->  Observable<Int> in
                guard idx < 3 else {
                    return Observable.error(error)
                }
                return Observable<Int>.timer(.seconds(5), scheduler: MainScheduler.instance)
            }
        } .subscribe(onNext: { (number) in
            print(" success get job")
        }, onError: { (error) in
            print(" error ")
        }).disposed(by: disposeBag)
    }

    func catchError(){
        let backUpObservable = Observable<Int>.create { (event) -> Disposable in


            event.onNext(1000)
            event.onCompleted()


            return Disposables.create()
        }

        let fetchDataObservable = Observable<Int>.create { (event) -> Disposable in

            if let url =  Bundle.main.url(forResource: "dept", withExtension: ".json") ,
                let data = try? Data(contentsOf: url){

            }


            print("try1")

            event.onError(DataError.cantParseJSON("jsonError"))
            event.onCompleted()


            return Disposables.create()
        }
        fetchDataObservable.catchError { (error) -> Observable<Int> in
            return backUpObservable
        }

        .subscribe(onNext: { (number) in
            print(" success get job \(number)")
        }, onError: { (error) in
            print(" error ")
        }).disposed(by: disposeBag)

        
    }

    func result(){
        //TestCatchErrorBtn.rx.tap
    }
}
