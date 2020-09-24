//
//  WeatherTableViewCell.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 9/23/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var lowTempLabel: UILabel!
    @IBOutlet private weak var highTempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
    }

    static let identifier = "WeatherTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell",
                     bundle: nil)
    }

    func configure(with model: Daily) {
        highTempLabel.textAlignment = .center
        lowTempLabel.textAlignment = .center
        iconImageView.contentMode = .scaleAspectFill
        lowTempLabel.text = "\(Int(model.temperature.min)-273)°"
        highTempLabel.text = "\(Int(model.temperature.max)-273)°"
        dayLabel.text = Date(timeIntervalSince1970: Double(model.dt)).getDay()
        let url = URL (string: ImageUrl.imageUrl.Url(icon: model.weather.first?.icon ?? ""))
        iconImageView.kf.setImage(with: url)
    }
}

