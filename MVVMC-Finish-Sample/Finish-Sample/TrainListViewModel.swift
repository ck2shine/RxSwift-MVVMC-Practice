//
//  TrainListViewModel.swift
//  Finish-Sample
//
//  Created by i9400503 on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

class TrainListViewModel {

    var dataList : Box<[TrainShowData]> = Box([])

    var trainStoreObj : TrainDataProtocol?

    init(trainStoreObj: TrainDataProtocol? = nil) {
        self.trainStoreObj = trainStoreObj
    }
}

extension TrainListViewModel{
    func refreshTableData(){
        //TODO ?

        guard let dataList = dataList.value ,dataList.isEmpty else {return}

        self.trainStoreObj?.fetchListData {[weak self] (trainItem, error) in
            guard let self = self else {return}
            self.dataList.value = trainItem.dataList ?? []
        }
    }
}
