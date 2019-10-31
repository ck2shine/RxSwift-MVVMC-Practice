//
//  TrainStoreObj.swift
//  Origianl-Sample
//
//  Created by i9400503 on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

class TrainStoreObj{
    static let shared = TrainStoreObj()


    var trainList :[TrainInfo]

    var trainTimeTable : [String:[TimeData]]

    init() {
        let fileUrl = Bundle.main.url(forResource: "trainData", withExtension: ".json")

        let data = try! Data(contentsOf: fileUrl!)

        let trainInfo = try! JSONDecoder().decode(TrainData.self, from: data)

        self.trainList = trainInfo.TrainInfos

        self.trainTimeTable = self.trainList.reduce([:], { (resultDict, trainInfo) -> [String:[TimeData]] in
            var resultDictpoint = resultDict
            let TrainNO = trainInfo.Train
            
            resultDictpoint[TrainNO] = trainInfo.TimeInfos
            return resultDictpoint
        })
    }

}



