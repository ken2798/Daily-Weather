//
//  WeatherCollectionViewCell.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 9/9/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    static let identifier = "WeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherCollectionViewCell",
                     bundle: nil)
    }
    
    func configure(with model: Hourly) {
        self.tempLabel.text = "\(Int(model.temperature)-273)°"
        self.iconImageView.contentMode = .scaleToFill
        self.timeLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt))) + ":00"
        let url = URL (string: "https://openweathermap.org/img/w/" + (model.weather.first?.icon ??  "") + ".png")
        do{
            let d = try Data(contentsOf: url!)
            self.iconImageView.image = UIImage(data: d)
        } catch {
            print("khong load icon")
        }
    }
    
    func configure1(with model: Current) {
        self.tempLabel.text = "\(Int(model.temperature)-273)°"
        self.iconImageView.contentMode = .scaleAspectFit
        self.timeLabel.text = "Now"
        let url = URL (string: "https://openweathermap.org/img/w/" + (model.weather.first?.icon ??  "") + ".png")
        do{
            let d = try Data(contentsOf: url!)
            self.iconImageView.image = UIImage(data: d)
        } catch {
            print("khong load icon")
        }
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: inputDate)
    }

}
