//
//  TrainListLineDelegates.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

protocol TrainListViewControllerDelegate : class {
    func didSelectTrainDetail(_ selectedTrainInfo : TrainInfo)
}

protocol TrainDetailViewControllerDelegate : class{
    func didSelectTrainNoForTimeTable(_ trainNo : String)
}
