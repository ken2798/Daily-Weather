//
//  TableViewCell.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/18/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let identifier = "TableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell",
                     bundle: nil)
    }

    
}
