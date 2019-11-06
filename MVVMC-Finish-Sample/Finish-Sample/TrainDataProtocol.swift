//
//  TrainDataProtocol.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

protocol TrainDataProtocol {

    var params : paramsItem? { get set }

    func fetchListData(_ complete : @escaping (TrainListItem , Error?)->())
}

struct paramsItem {
    var trainNo : String?
}
