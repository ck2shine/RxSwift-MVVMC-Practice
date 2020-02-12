//
//  RxCreateObservable.swift
//  RxSwift-Sample
//
//  Created by i9400503 on 2020/2/4.
//  Copyright © 2020 Brille. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
extension ViewController{
    func RxCreateObservable(){
        //merg()
        //window()
        //        flatMap()
        //        flatmaplatest()
        //        flatMap2()
        //        concatMap()
        //        publicReqeust()
        share()
        //        withLatestFrom()
        //        testFunction()
    }
}

extension ViewController{
    
    //just
    func just(){
        
        
        
        let three = Observable.just(3)
        
        let threeComplicated = Observable<Int>.create { (event) -> Disposable in
            event.onNext(3)
            event.onCompleted()
            return Disposables.create()
        }
        
    }
    
    //timer
    func timer(){
        Observable<Int>.timer(.seconds(0), period: .seconds(3), scheduler: MainScheduler.instance)
    }
    
    func from(){
        let aryObs = Observable.from([1,2,3])
        let aryObsSame =  Observable<Int>.create { (event) -> Disposable in
            event.onNext(1)
            event.onNext(2)
            event.onNext(3)
            event.onCompleted()
            return Disposables.create()
        }
        
        
        var name : String? = ""
        Observable.from(optional: name)
    }
    
    
    func merg(){
        
        let netAPIObservable1 = PublishSubject<String>()
        let netAPIObservable2 = PublishSubject<String>()
        
        Observable.of(netAPIObservable1,  netAPIObservable2.catchErrorJustReturn("ap2error"))
            .merge()
            .subscribe(onNext: { (str) in
                print("print str : \(str)")
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("both compleete")
            })
            .disposed(by: disposeBag)
        netAPIObservable1.onNext("api1")
        
        netAPIObservable2.onNext("api2")
        
        
        //netAPIObservable1.onCompleted()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let error = DataError.cantParseJSON("ccc")
            netAPIObservable2.onError(error)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            netAPIObservable1.onCompleted()
        }
        
        
        
        
    }
    
    func relay(){
        // remove events of oncomplete and onerror
        
        // PublicObject - > PublishRelay
        // BehaviorObject - > BehaviorRelay
    }
    
    
    
    func window(){
        let subject = PublishSubject<String>()
        subject.window(timeSpan: .seconds(3), count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { (observable) in
                print("item \(observable)")
                
                observable.subscribe(onNext: { (str) in
                    print("inside \(str)")
                })
            }, onError: { (error) in
                
            })
            .disposed(by: disposeBag)
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }
    
    func flatMap(){
        
        //map - > change original observable value
        //flatMap -> take the item transform to other onservable
        
        Observable<Int>.of(1, 2, 3).map { (numb) -> String in
            return "\(numb)"
        } .subscribe(onNext: { element in
            print("str:", element)
        })
            .disposed(by: disposeBag)
        
        
        Observable<Int>.of(1, 2, 3).flatMap {  Observable<String>.just("\($0)") }
            .subscribe(onNext: { element in
                print("element:", element)
            })
            .disposed(by: disposeBag)
        
    }
    
    func flatmaplatest(){
        
        
        let outerObservable = Observable<NSInteger>
            .interval(.milliseconds(500), scheduler: MainScheduler.instance)
            .take(4)
        
        //let outerObservable = Observable<Int>.of(1,2,3,4)
        
        let combinedObservable = outerObservable.flatMapLatest { value in
            return Observable<Int>
                .interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .take(4)
                .map { innerValue in
                    print("Outer Value \(value) Inner Value \(innerValue)")
            }
        }
        
        combinedObservable
            .subscribe()
            .disposed(by: disposeBag)
        
    }
    
    func flatMap2(){
        //        let outerObservable = Observable<Int>.of(5,10,20)
        //
        //        let combineObservable = outerObservable.flatMapLatest { value in
        //            return Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(2).map { valueInner in
        //                print(" other value \(value) , Innter Value \(valueInner)")
        //            }
        //        }
        //
        //        combineObservable.subscribe().disposed(by: disposeBag)
        
        
        
        
        let subject = PublishSubject<Int>()
        
        let other =  subject.map{String($0)}
            .window(timeSpan: .seconds(1), count: 10, scheduler: MainScheduler.instance)
        
        
        
        other.subscribe(onNext: { (event) in
            print(event)
        }).disposed(by: disposeBag)
        
        
        
        //        subject.flatMapLatest { value in
        //            return Observable<String>
        //        }
    }
    
    func concatMap(){
        let outerObservable = Observable<NSInteger>
            .interval(0.5, scheduler: MainScheduler.instance)
            .take(2)
        
        let combinedObservable = outerObservable.concatMap { value in
            return Observable<NSInteger>
                .interval(0.3, scheduler: MainScheduler.instance)
                .take(3)
            //                .map { innerValue in
            //                    print("Outer Value \(value) Inner Value \(innerValue)")
            //            }
        }
        
        combinedObservable
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func publicReqeust(){
        
        let request =   Observable<Int>
            .interval(.seconds(3), scheduler: MainScheduler.instance)
            .take(2)
            .map{
                "\($0)"
        }
        .flatMapLatest { value in
            return Observable<String>.create{
                observer in
                print("request netApi")
                observer.onNext("success : \(value)")
                return Disposables.create ()
            }
        }.publish()
        
        request.subscribe(onNext: { (str) in
            print("fist subscribe :\(str)")
        }).disposed(by: disposeBag)
        
        request.subscribe(onNext: { (str) in
            print("second subscribe :\(str)")
        }).disposed(by: disposeBag)
        
        _ = request.connect()
        
    }
    
    func share(){
        
        //        let request = Observable<Int>
        //            .interval(.seconds(2), scheduler: MainScheduler.instance)
        //            .take(1)
        //            .map{
        //                "\($0)"
        //        }
        //        .flatMapLatest { value in
        //            return Observable<String>.create{
        //                observer in
        //                print("request netApi")
        //                observer.onNext("success : \(value)")
        //                return Disposables.create ()
        //            }
        //        }.share()
        //
        //        request.subscribe(onNext: { (str) in
        //            print("fist subscribe :\(str)")
        //        })
        //            .disposed(by: disposeBag)
        //
        //        request.subscribe(onNext: { (str) in
        //            print("second subscribe :\(str)")
        //        })
        //            .disposed(by: disposeBag)
        //
        //        //second
        
        
        let request = Observable<Int>
            .interval(.seconds(2), scheduler: MainScheduler.instance)
            .take(1)
            .map{"\($0)"}
            .flatMapLatest { value in
                return Observable<String>.create{
                    observer in
                    print("request netApi")
                    observer.onNext("emit 1 : \(value)")
                    observer.onNext("emit 2 : \(value)")
                    return Disposables.create ()
                }
        }.share(replay: 1, scope: .whileConnected)
        
        let first = request.map{"first transform \($0)"}
        let second = request.map{"second transform \($0)"}
        let _ =  first.map{"\($0)"} //1 subscriber
            .subscribe(onNext: { (str) in
                print("first subscribe :\(str)")
            })
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now()+3) {
            let _ =  second.map{"\($0)"}  //2 subscriber
                .subscribe(onNext: { (str) in
                    print("second subscribe :\(str)")
                })
        }
        
        //        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now()+3) {
        //            a.dispose()
        //        }
        //
        //
        //        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now()+6) {
        //
        //            second.subscribe(onNext: { (str) in
        //                print("second subscribe :\(str)")
        //            })
        //                .disposed(by: self.disposeBag)
        //        }
        
        
    }
    
    
    func withLatestFrom(){
        var firstObservable = PublishSubject<String>()
        var secondObservable = PublishSubject<String>()
        
        firstObservable.withLatestFrom(secondObservable){(first , second) in
            return first + second
        }
        .subscribe(onNext: { (str) in
            print(str )
        })
            .disposed(by: disposeBag)
        secondObservable.onNext("sec : 1")
        secondObservable.onNext("sec : 2")
        
        firstObservable.onNext("first : 3")
        
    }
    
    func testFunction(){
        TestButton.rx.tap.flatMapLatest {_ in
            return Observable<String>.create { (event) -> Disposable in
                
                event.onNext("3")
                DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
                    
                    event.onError( DataError.cantParseJSON("ccc"))
                }
                return Disposables.create()
            }.map { (str)  in
                return Result<String, DataError>.success(str)
            }.catchError{ error  in
                let dataError = error as! DataError
                return Observable.just(Result<String, DataError>.failure(dataError))
            }
        }
        .subscribe(onNext: { (result) in
            switch result{
            case .success(let str):
                print("success str \(str)")
            case.failure(let error):
                
                print("subject failed : \(error.description)")
            }
        },onError: {error in
            
            print(error)
            
        }).disposed(by: disposeBag)
    }
}
