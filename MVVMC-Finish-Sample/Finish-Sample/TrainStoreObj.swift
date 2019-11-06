//
//  TrainStoreObj.swift
//  Origianl-Sample
//
//  Created by Shine on 2019/10/23.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

class TrainStoreObj : TrainDataProtocol{

    var params: paramsItem?

    func fetchListData(_ complete: @escaping(TrainListItem, Error?) -> ()) {
        
        var resultItem = TrainListItem()
        defer{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                 complete(resultItem , nil)
            }
        }

        let fileUrl = Bundle.main.url(forResource: "trainData", withExtension: ".json")

        let data = try! Data(contentsOf: fileUrl!)

        let trainInfo = try! JSONDecoder().decode(TrainData.self, from: data)

        resultItem.dataList = trainInfo.TrainInfos
    }
}



