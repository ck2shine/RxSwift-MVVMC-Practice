//
//  TrainDataModel.swift
//  Origianl-Sample
//
//  Created by i9400503 on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

struct TrainData : Codable{
    var TrainInfos : [TrainInfo]
}

struct TrainInfo : Codable{
    var Train : String
    var Note : String
    var TimeInfos : [TimeData]
}

struct TimeData : Codable {
    var Station : String
    var ARRTime : String
    var DEPTime : String
}
