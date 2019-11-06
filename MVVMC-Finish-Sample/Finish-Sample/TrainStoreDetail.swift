//
//  TrainStoreDetail.swift
//  Finish-Sample
//
//  Created by i9400503 on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation
class TrainStoreDetail : TrainDataProtocol{

    var params: paramsItem?

    func fetchListData( _ complete: @escaping(TrainListItem, Error?) -> ()) {
        var resultItem = TrainListItem()

        defer{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                complete(resultItem , nil)
            }
        }

        let fileUrl = Bundle.main.url(forResource: "trainData", withExtension: ".json")

        let data = try! Data(contentsOf: fileUrl!)

        let trainInfo = try! JSONDecoder().decode(TrainData.self, from: data)

        //Transfer to Dict
        let dataDict = trainInfo.TrainInfos.reduce([:], { (resultDict, trainInfo) -> [String:[TimeData]] in
            var resultDictpoint = resultDict
            let TrainNO = trainInfo.Train

            resultDictpoint[TrainNO] = trainInfo.TimeInfos

            return resultDictpoint
        })

        if let params = params {
            let word = params.trainNo
             resultItem.dataList = dataDict[word!]
        }
    }

}
