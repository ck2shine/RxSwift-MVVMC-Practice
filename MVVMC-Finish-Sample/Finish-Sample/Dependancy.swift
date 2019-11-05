//
//  Dependancy.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/4.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

protocol CoordinatorDependancy {
    associatedtype dataInfo
    var dependency : DataObjectDependancy<Any, Any>?{ get set}
}



