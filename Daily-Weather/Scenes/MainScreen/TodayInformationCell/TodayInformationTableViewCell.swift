//
//  TodayInformationTableViewCell.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/7/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class TodayInformationTableViewCell: UITableViewCell {
    @IBOutlet private weak var sunRiseLabel: UILabel!
    @IBOutlet private weak var sunDownLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var feelLikeLabel: UILabel!
    @IBOutlet private weak var cloudsLabel: UILabel!
    @IBOutlet private weak var uviLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
    }
    
    static let identifier = "TodayInformationTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "TodayInformationTableViewCell",
                     bundle: nil)
    }
    
    func configure(with model: Current) {
        self.sunRiseLabel.text = Date.date.getDayForDate(date: Date(timeIntervalSince1970: Double(model.dt)))
        self.sunDownLabel.text = Date.date.getDayForDate(date: Date(timeIntervalSince1970: Double(model.dt)))
        self.pressureLabel.text = "\(Int(model.pressure)) hPa"
        self.humidityLabel.text = "\(Int(model.humidity))%"
        self.windSpeedLabel.text = "\(model.windSpeed) km/h"
        self.feelLikeLabel.text = "\(Int(model.feelsLike)-273)°C"
        self.cloudsLabel.text = "\(model.clouds)"
        self.uviLabel.text = "\(model.uvi)"
    }
}
