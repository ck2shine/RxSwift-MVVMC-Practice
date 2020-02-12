//
//  RxRelays.swift
//  RxSwift-Sample
//
//  Created by Shine on 2020/2/12.
//  Copyright © 2020 Brille. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
extension ViewController{
    
    func PublishRelays(){
        
        //publishRelays
        //!!!Remeber to import Rxcoca!!!
        let pbRelays = PublishRelay<String>()
        pbRelays.asDriver(onErrorJustReturn: "error occurs")
            .drive(onNext: { str in
                //any UI change
                self.NameLabel.text = str
            })
            .disposed(by: disposeBag)
        
        //pbRelays.accept("Jane")
        
        //Behavior Replays
        let bhRelays = BehaviorRelay<String>(value: "no name")
        bhRelays.accept("Mary")
        bhRelays.accept("Jane \(bhRelays.value)")
        
        bhRelays.asDriver(onErrorJustReturn: "error occurs")
            .drive(onNext: { str in
                //any UI change
                self.NameLabel.text = str
            })
            .disposed(by: disposeBag)

         bhRelays.accept("Jennifer")
        
    }
    
}
