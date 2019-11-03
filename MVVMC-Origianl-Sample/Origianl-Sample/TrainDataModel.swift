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

struct TrainInfo : Codable , TrainShowData{
    var mainTitle: String? {
        return "火車編號 : \(Train)"
    }
    
    var subTitle: String?{
        return Note
    }
    
    var Train : String
    var BreastFeed : String
    var CarClass : String
    var Cripple : String
    var Bike : String    
    var Note : String
    var TimeInfos : [TimeData]
}

struct TimeData : Codable , TrainShowData{
    var mainTitle: String?{
        return "車站代碼 : \(Station)"
    }
    
    var subTitle: String?{
        return ARRTime
    }
    
    var Station : String
       
    var ARRTime : String
   
    
}


protocol TrainShowData {
    var mainTitle : String?{get }
    var subTitle : String?{get }
}
