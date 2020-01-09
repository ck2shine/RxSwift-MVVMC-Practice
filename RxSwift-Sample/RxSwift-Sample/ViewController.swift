//
//  ViewController.swift
//  RxSwift-Sample
//
//  Created by i9400503 on 2020/1/3.
//  Copyright © 2020 Brille. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class ViewController: UIViewController {

    typealias JSON = [Department]
    var json :Observable<JSON>?
    var jsonSingle : Single<[Department]>?
    var jsonCompletable : Completable?
    var jsonMaybe : Maybe<[Department]>?

    let disposeBag = DisposeBag()

    var testString :String = ""

    @IBOutlet weak var TestButton: UIButton!
    @IBOutlet weak var InputTextField: UITextField!
    
    @IBOutlet weak var InputValidLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //self.RxBinding()
      
        
        self.RxObserver_eventSubscrite()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.5) {
            self.json?.subscribe(onNext: {
                print("json success \($0)")
            }, onError: {
                print("json fail \($0.localizedDescription)")
            }, onCompleted: {
                print("json task complete")
            }).disposed(by: self.disposeBag)

            self.jsonSingle?.subscribe(onSuccess: {
                print("json success \($0)")
            }, onError: {
                print("json fail \($0.localizedDescription)")
            })

            self.jsonCompletable?.subscribe(onCompleted: {
                print("task complete")
            }, onError: {
                print("json fail \($0.localizedDescription)")
            })

            self.jsonMaybe?
                .subscribe(onSuccess: {
                    print("json success \($0)")
                },onError: {
                    print("json fail \($0.localizedDescription)")
                },onCompleted: {
                print("complete")
            })
        }


    }

}

extension ViewController {

    enum DataError : Error {
        case cantParseJSON(_ message:String)

        var description:String{
            switch self{
            case .cantParseJSON(let message) : return message
            }
        }
    }

    private func RxBinding(){
        //make observable object
        let textObs = InputTextField.rx.text.orEmpty.asObservable()

        //make another obserable<Bool>
        let idValid = textObs.map {$0.count > 0}

        //make observer event
        let observer = InputValidLabel.rx.isHidden

        let disposable = idValid
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .bind(to: observer)

        //create one observe
        let numbers : Observable<Int> = Observable.create({ (observe) -> Disposable in
            observe.onNext(0)
            observe.onNext(1)
            observe.onNext(2)
            observe.onNext(3)
            observe.onNext(4)
            observe.onNext(5)
            observe.onNext(6)
            observe.onNext(7)
            observe.onNext(8)
            observe.onNext(9)
            observe.onCompleted()
            return Disposables.create()
        })
        //normal create
        //        json = getDeptNormal()
        //Single create
        //jsonSingle = getDeptNormal().asSingle()
        //        jsonSingle = getDeptSingle()
        jsonCompletable = getDelpComplete()
       let event =  InputTextField.rx.text
    }
}
//MARK: event
extension ViewController{

    final private func getDeptNormal() -> Observable<JSON>{
        return Observable<JSON>.create { (observe) -> Disposable in


            //make a event
            if let url = Bundle.main.url(forResource: "dept", withExtension: ".json") , let data = try? Data(contentsOf: url){
                let decoder = JSONDecoder()

                guard let result = try? decoder.decode([Department].self, from: data) else {
                    observe.onError(DataError.cantParseJSON("jsonError"))
                    return Disposables.create()
                }
                observe.onNext(result)
                observe.onCompleted()

            }
            return Disposables.create()

        }

    }

    final private func getDeptSingle() -> Single<[Department]>{
        return Single<[Department]>.create { (single) -> Disposable in
            //make a event
            if let url = Bundle.main.url(forResource: "dept", withExtension: ".json") , let data = try? Data(contentsOf: url){
                let decoder = JSONDecoder()

                guard let result = try? decoder.decode([Department].self, from: data) else {
                    single(.error(DataError.cantParseJSON("jsonError")))
                    return Disposables.create()
                }
                single(.success(result))
            }
            return Disposables.create()
        }
    }

    final private func getDelpComplete() -> Completable{
        return Completable.create { (completable) -> Disposable in
            if let url = Bundle.main.url(forResource: "dept", withExtension: ".json") , let data = try? Data(contentsOf: url){
                let decoder = JSONDecoder()

                guard let _ = try? decoder.decode([Department].self, from: data) else {
                    completable(.error(DataError.cantParseJSON("jsonError")))
                    return Disposables.create()
                }
                completable(.completed)
            }
            return Disposables.create()
        }
    }

    final private func getDeptMaybe() -> Maybe<[Department]>{
        return Maybe<[Department]>.create { (maybe) -> Disposable in
            if let url = Bundle.main.url(forResource: "dept", withExtension: ".json") , let data = try? Data(contentsOf: url){
                let decoder = JSONDecoder()

                guard let result = try? decoder.decode([Department].self, from: data) else {
                    maybe(.error(DataError.cantParseJSON("jsonError")))
                    return Disposables.create()
                }
                maybe(.success(result))
                maybe(.completed)
            }
            return Disposables.create()
        }
    }
}
