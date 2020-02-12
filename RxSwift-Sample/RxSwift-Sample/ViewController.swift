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
    
    var errorObject = PublishSubject<DataError>()
    
    var errorEvent : Driver<String> {
        return errorObject.map{$0.description}
            .asDriver(onErrorJustReturn: "can not get error description")
    }
    
    var json :Observable<JSON>?
    var jsonSingle : Single<[Department]>?
    var jsonCompletable : Completable?
    var jsonMaybe : Maybe<[Department]>?
    var driverSignal : Driver<Void>?
    var jsonSignal : Signal<Void>?
    
    var publicObservable : Observable<String>?
    var scheduleObservable : Observable<String>?
    
    var disposeBag = DisposeBag()
    
    var testString :String = ""
    
    @IBOutlet weak var TestButton: UIButton!
    @IBOutlet weak var InputTextField: UITextField!
    
    @IBOutlet weak var EventButton: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var InputValidLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.RxBinding()
        
        
        //self.RxObserver_eventSubscrite()
        
        //RxObservalAndObserver()
        //RxOperator()
        
        //RxScheduler()
        //RxErrorHandler()
        //        RxCreateObservable()
//        startToTest()
        //normalBinding()
//        PublishRelays()
//        share()
        twoWayInputs()
    }
    
    var inputRelay = BehaviorRelay<String>(value: "")
    
    
    func twoWayInputs(){
        //from viewmodel to ui
             
    
        InputTextField.rx.text.filter({ (str) -> Bool in
            print("see str \(str!)")
            return !(str?.isEmpty ?? true)
        }).subscribe(onNext: { (str) in
            print("CCcc")
            }).disposed(by: disposeBag)
        
        inputRelay.asObservable()
                               .bind(to: InputTextField.rx.text)
                           .disposed(by: disposeBag)
      
        inputRelay.accept("Shineccc")
       
        
        //input
        
        
//        InputTextField.rx.text.orEmpty.bind(to: inputRelay).disposed(by: disposeBag)
                      
      
//        inputRelay.accept("Shine")
        
        //load data
//        inputRelay.accept("Shine")
    }
    
    func normalBinding(){
        
        //error
        errorEvent.drive(onNext: {  [weak self] errorMsg  in
            guard let self = self else {return}
            let alertController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
            .disposed(by: disposeBag)
    }
    
    
    private let items = BehaviorRelay<[String]>(value: [])
    private let syncData = BehaviorRelay<Bool>(value: false)
    var loading = BehaviorRelay<Bool>(value: false)
    
    var isLoading : Driver<Bool>{
        return loading.asDriver(onErrorJustReturn: false)
    }
    
    @IBOutlet weak var dataActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var loadingButton: UIButton!
    
    private let triggerFetchData = PublishSubject<()>()
    
    func startToTest(){
        
         rx.sentMessage(#selector(viewDidAppear(_:)))
             .map{_ in ()}
             .bind(to: triggerFetchData)
             .disposed(by: disposeBag)
        
        //fetch data
        let fetchTask = triggerFetchData.flatMapLatest { _ -> Observable<[String]> in
            return Observable.create({ event in
                DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                    print("fetch data start")
                    event.onNext(["1","2","3"])
                    event.onCompleted()
                }
                return Disposables.create()
            })
        }.catchErrorJustReturn(["errror"])
            .share()
        
        //write item and reload table
        items.filter{!$0.isEmpty}
              .flatMapLatest{item in
                  return Observable<Bool>.create({ event  in
                      event.onNext(false)
                      print("write in item :\(item)")
                      DispatchQueue.global().asyncAfter(deadline: .now()+5) {
                           event.onNext(true)
                           event.onCompleted()
                      }

                      return Disposables.create()
                  })
          }
              .bind(to: syncData)
              .disposed(by: disposeBag)
        
        //subscribe trigger fetch data
        fetchTask.bind(to: items)
            .disposed(by: disposeBag)
        
        
        isLoading
            .map{!$0}
            .drive(loadingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        isLoading
            .drive(dataActivity.rx.isAnimating)
            .disposed(by: disposeBag)
        //behavior has a default value
        BehaviorRelay.merge( syncData.map{_ in
            print("cccccc sync")
            return false},  items.map{_ in
                print("hey hey hey")
                return true}
            .asObservable()
        )
            .bind(to: loading)
            .disposed(by: disposeBag)
    }
    
    @IBOutlet weak var TestCatchErrorBtn: UIButton!
    @IBAction func testCatchError(_ sender: Any) {
        
        //errorObject.onNext(DataError.cantParseJSON("test error"))
        
        //items.accept(["123"])
        //        self.publicObservable!.subscribe(onNext: { (str) in
        //            print("third subscribe :\(str)")
        //        })
        //            .disposed(by: self.disposeBag)
        
    }
    @IBAction func clearAction(_ sender: Any) {
//        print(inputRelay.value)
//        self.disposeBag = DisposeBag()
    }
    
    @IBAction func eventAction(_ sender: Any) {
//        triggerFetchData.onNext(())
        items.accept(["123"])
        //        scheduleObservable?
        //            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
        //            .observeOn(MainScheduler.instance)
        //            .subscribe(onNext: { (str) in
        //                print(str)
        //            }).disposed(by: self.disposeBag)
        
        
        
        
        //        jsonSignal?.emit(onNext: { _ in
        //            print("kkkkkkk")
        //        })
        
        //        driverSignal?.drive(onNext: { (_) in
        //            print("akakakakakak")
        //        })
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.5) {
            
            
            
            //            self.json?.subscribe(onNext: {
            //                print("json success \($0)")
            //            }, onError: {
            //                print("json fail \($0.localizedDescription)")
            //            }, onCompleted: {
            //                print("json task complete")
            //            }).disposed(by: self.disposeBag)
            //
            //            self.jsonSingle?.subscribe(onSuccess: {
            //                print("json success \($0)")
            //            }, onError: {
            //                print("json fail \($0.localizedDescription)")
            //            })
            //
            //            self.jsonCompletable?.subscribe(onCompleted: {
            //                print("task complete")
            //            }, onError: {
            //                print("json fail \($0.localizedDescription)")
            //            })
            //
            //            self.jsonMaybe?
            //                .subscribe(onSuccess: {
            //                    print("json success \($0)")
            //                },onError: {
            //                    print("json fail \($0.localizedDescription)")
            //                },onCompleted: {
            //                    print("complete")
            //                })
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
        //        let textObs = InputTextField.rx.text.orEmpty.asObservable()
        //
        //        //make another obserable<Bool>
        //        let idValid = textObs.map {$0.count > 0}
        //
        //        //make observer event
        //        let observer = InputValidLabel.rx.isHidden
        //
        //        let disposable = idValid
        //            .subscribeOn(MainScheduler.instance)
        //            .observeOn(MainScheduler.instance)
        //            .bind(to: observer)
        
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
        
        
        
        //        driverSignal = TestButton.rx.tap.asDriver()
        //
        //        driverSignal?.drive(onNext: { (_) in
        //            print("drive 1111")
        //        })
        
        jsonSignal = TestButton.rx.tap.asSignal()
        
        jsonSignal?.emit(onNext: {  _  in
            print("ccccc")
        }).disposed(by: disposeBag)
        
        //        let event =  InputTextField.rx.text.asDriver()
        //        event.map {"\($0?.count ?? 0)"}
        //             .drive(NameLabel.rx.text)
        //        .disposed(by: disposeBag)
        //
        //        event.map{$0?.count ?? 0 > 0 }
        //            .drive(InputValidLabel.rx.isHidden)
        //        .disposed(by: disposeBag)
        
        
        //        let event =  InputTextField.rx.text.as
        //               event.map {"\($0?.count ?? 0)"}
        //                    .drive(NameLabel.rx.text)
        //               .disposed(by: disposeBag)
        //
        //               event.map{$0?.count ?? 0 > 0 }
        //                   .drive(InputValidLabel.rx.isHidden)
        //               .disposed(by: disposeBag)
        
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
