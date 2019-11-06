//
//  TrainListController.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

class TrainListController{
    
    var viewModel : TrainListViewModel
    
    init(viewModel : TrainListViewModel) {
        self.viewModel = viewModel
    }
}

extension TrainListController{
    final func refreshTableData(){
      
        self.viewModel.triggerDataFetch = {[unowned self]  (trainItem) in
            self.viewModel.originalData = trainItem.dataList
            self.viewModel.isLoading.value = false
        }
        
//        self.viewModel.trainStoreObj?.fetchListData {[weak self] (trainItem, error) in
//            guard let self = self else {return}
//            self.viewModel.originalData = trainItem.dataList
//            let dataList = self.viewModel.buildCellViewModels(dataList: trainItem.dataList ?? [])
//            self.viewModel.dataList.value = dataList
//            self.viewModel.isLoading.value = false
//        }
    }
    
    final func logout(){
        self.viewModel.logout.value = true
    }
}
