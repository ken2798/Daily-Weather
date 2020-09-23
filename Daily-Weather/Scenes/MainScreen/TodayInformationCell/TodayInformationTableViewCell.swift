//
//  TodayInformationTableViewCell.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/7/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class TodayInformationTableViewCell: UITableViewCell {
    @IBOutlet private weak var sunRiseLb: UILabel!
    @IBOutlet private weak var sunDownLb: UILabel!
    @IBOutlet private weak var pressureLb: UILabel!
    @IBOutlet private weak var humidityLb: UILabel!
    @IBOutlet private weak var windSpeedLb: UILabel!
    @IBOutlet private weak var feelLikeLb: UILabel!
    @IBOutlet private weak var cloudsLb: UILabel!
    @IBOutlet private weak var uviLb: UILabel!
    
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
        self.sunRiseLb.text = Date.init().getDayForDate(date: Date(timeIntervalSince1970: Double(model.dt)))
        self.sunDownLb.text = Date.init().getDayForDate(date: Date(timeIntervalSince1970: Double(model.dt)))
        self.pressureLb.text = "\(Int(model.pressure)) hPa"
        self.humidityLb.text = "\(Int(model.humidity))%"
        self.windSpeedLb.text = "\(model.windSpeed) km/h"
        self.feelLikeLb.text = "\(Int(model.feelsLike)-273)°C"
        self.cloudsLb.text = "\(model.clouds)"
        self.uviLb.text = "\(model.uvi)"
    }
}
