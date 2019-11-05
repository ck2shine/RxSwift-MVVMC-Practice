//
//  TrainListLineDelegates.swift
//  Finish-Sample
//
//  Created by i9400503 on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import Foundation

protocol TrainListViewControllerDelegate : class {
    func didSelectTrainDetail(_ selectedTrainInfo : TrainShowData)
}

protocol TrainDetailViewControllerDelegate : class{

}
