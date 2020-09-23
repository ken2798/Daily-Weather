//
//  TodayDetailTableViewCell.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/7/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class TodayDetailTableViewCell: UITableViewCell {
    @IBOutlet private weak var detailLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
    }

    static let identifier = "TodayDetailTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "TodayDetailTableViewCell",
                     bundle: nil)
    }

    func configure(with model: Current) {
        self.detailLb.text = "Today: It's \(model.weather[0].description) right now. Present temperature is \(Int(model.temperature)-273)°C. The perceptible temperature is approx \(Int(model.feelsLike)-273)°C."
    }
    
}
