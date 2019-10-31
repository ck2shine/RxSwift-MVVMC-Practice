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
    var mainTitle: String?
    
    var subTitle: String?
    
    var Train : String{
        didSet
        {
            self.mainTitle = "火車編號:\(Train)"
        }
    }
    
    
    var Note : String{
        didSet
        {
            self.subTitle = Note
        }
    }
    var TimeInfos : [TimeData]
}

struct TimeData : Codable , TrainShowData{
    var mainTitle: String?
    
    var subTitle: String?
    
    var Station : String
    {
        didSet
        {
            self.mainTitle = "車站代碼:\(Station)"
        }
    }
    
    var ARRTime : String
    {
           didSet
           {
               self.subTitle = ARRTime
           }
       }
    
}


protocol TrainShowData {
    var mainTitle : String?{get set}
    var subTitle : String?{get set}
}
