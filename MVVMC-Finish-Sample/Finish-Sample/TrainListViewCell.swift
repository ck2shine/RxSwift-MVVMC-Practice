//
//  TrainListViewCell.swift
//  Finish-Sample
//
//  Created by Shine on 2019/11/6.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

class TrainListViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupCell(viewModel : TrainListCellViewModel){
        self.textLabel?.text = viewModel.mainTitle
        self.detailTextLabel?.numberOfLines = 0
        self.detailTextLabel?.text = viewModel.subTitle
        self.accessoryType = viewModel.accessoryType ?? UITableViewCell.AccessoryType.none
    }
}


