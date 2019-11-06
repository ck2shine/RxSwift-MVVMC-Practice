//
//  TrainListCellViewModel.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation
import UIKit
class TrainListCellViewModel{
    
    var mainTitle : String?
    
    var subTitle : String?
   
    var accessoryType :  UITableViewCell.AccessoryType?
    
    init(showDataDict : TrainShowData , accessoryType : UITableViewCell.AccessoryType) {
        self.mainTitle = showDataDict.mainTitle
        self.subTitle = showDataDict.subTitle
        self.accessoryType = accessoryType
    }
}
