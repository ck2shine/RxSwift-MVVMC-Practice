//
//  TrainStoreObj.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

class DataObjectDependancy<T,K> {
    var dataList : [T]?
    var dataDict : [String:[K]]?
}

class TrainStoreObj : DataObjectDependancy<TrainInfo,TimeData>{

    override init() {
        let fileUrl = Bundle.main.url(forResource: "trainData", withExtension: ".json")

        let data = try! Data(contentsOf: fileUrl!)

        let trainInfo = try! JSONDecoder().decode(TrainData.self, from: data)

        self.dataList = trainInfo.TrainInfos

        self.dataDict = self.dataList.reduce([:], { (resultDict, trainInfo) -> [String:[TimeData]] in
            var resultDictpoint = resultDict
            let TrainNO = trainInfo.Train
            
            resultDictpoint[TrainNO] = trainInfo.TimeInfos
            
            return resultDictpoint
        })
    }

}



