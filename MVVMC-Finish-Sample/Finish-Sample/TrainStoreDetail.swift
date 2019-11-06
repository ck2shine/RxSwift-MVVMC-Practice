//
//  TrainStoreDetail.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation
class TrainStoreDetail : TrainDataProtocol{
    
    var params: paramsItem? = paramsItem()
    
    let taskQueue =  DispatchQueue(label: "timeTableQuere", qos: .default, attributes: .concurrent)
    
    func fetchListData( _ complete: @escaping(TrainListItem, Error?) -> ()) {
        taskQueue.async {
            var resultItem = TrainListItem()
            
            defer{
                
                DispatchQueue.main.async {
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
            
            if let params = self.params {
                let trainNo = params.trainNo
                resultItem.dataList = dataDict[trainNo!]
            }           
        }
        
    }
    
}
