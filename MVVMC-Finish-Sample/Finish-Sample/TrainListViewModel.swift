//
//  TrainListViewModel.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation
import UIKit

enum listBarItemMode {
       case activity , logout , both , none
   }

protocol TrainListViewModelInput {
     var triggerDataFetch : ((TrainListItem)->())?{ get set}
//    var addTodoAction: PublishSubject<String> { get }
//    var refreshTrigger: PublishSubject<Void> { get }
//    var toggleTodoAction: PublishSubject<Int> { get }
}

protocol TrainListViewModelOutput {
    var addBarItem : Box<listBarItemMode> { get set}
    var isLoading : Box<Bool> { get set}
    var dataList : Box<[TrainListCellViewModel]> { get set}
    var logout : Box<Bool> { get set}
}

protocol TrainListViewModelType {
    var inputs: TrainListViewModelInput { get }
    var outputs: TrainListViewModelOutput { get}
}

class TrainListViewModel : TrainListViewModelType ,TrainListViewModelInput ,TrainListViewModelOutput{
    
   var inputs: TrainListViewModelInput {
    return self
    
    }
   var outputs: TrainListViewModelOutput {
    return self
    }
    
    //input
    var triggerDataFetch : ((TrainListItem)->())?{
        didSet{
            trainStoreObj?.fetchListData {[weak self] (trainItem, error) in
                guard let self = self else {return}                
                let dataList = self.buildCellViewModels(dataList: trainItem.dataList ?? [])
                self.dataList.value = dataList
                self.triggerDataFetch?(trainItem)
            }
        }
    }
    
    //output
    var addBarItem : Box<listBarItemMode> = Box(.both)
    var isLoading : Box<Bool> = Box(true)
    var dataList : Box<[TrainListCellViewModel]> = Box([])
    var logout : Box<Bool> = Box(false)
        
    
    var trainStoreObj : TrainDataProtocol?
    var originalData : [TrainShowData]?
    
    init(trainStoreObj: TrainDataProtocol? = nil) {
        self.trainStoreObj = trainStoreObj
        self.addBarItem.value = trainStoreObj is TrainStoreObj ? .both : .activity
        
    }
}

extension TrainListViewModel{
    
    func buildCellViewModels(dataList : [TrainShowData]) -> [TrainListCellViewModel]{
        return  dataList.map { (trainShowDataInfo) -> TrainListCellViewModel in
            
            let accessoryType : UITableViewCell.AccessoryType = trainStoreObj is TrainStoreObj ? .disclosureIndicator : .none
            
            return TrainListCellViewModel(showDataDict: trainShowDataInfo, accessoryType: accessoryType)
        }
    }
}
