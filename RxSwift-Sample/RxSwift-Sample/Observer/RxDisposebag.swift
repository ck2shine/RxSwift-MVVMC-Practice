//
//  RxDisposebag.swift
//  RxSwift-Sample
//
//  Created by i9400503 on 2020/2/3.
//  Copyright © 2020 Brille. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
extension ViewController{
    
    func RxDisposebag(){
        
        //assign a new DisposeBag to clean
        self.disposeBag = DisposeBag()
    }
    
}
