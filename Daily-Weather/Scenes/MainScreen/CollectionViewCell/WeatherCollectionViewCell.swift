//
//  WeatherCollectionViewCell.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 9/9/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    static let identifier = "WeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherCollectionViewCell",
                     bundle: nil)
    }
    
    func configure(with model: Hourly) {
        tempLabel.text = "\(Int(model.temperature)-273)°"
        iconImageView.contentMode = .scaleToFill
        timeLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt))) + ":00"
        let url = URL (string: ImageUrl.imageUrl.Url(icon: model.weather.first?.icon ?? ""))
        do{
            let d = try Data(contentsOf: url!)
            iconImageView.image = UIImage(data: d)
        } catch {
            return
        }
    }
    
    func configureFirst(with model: Current) {
        tempLabel.text = "\(Int(model.temperature)-273)°"
        iconImageView.contentMode = .scaleAspectFit
        timeLabel.text = "Now"
        let url = URL (string: ImageUrl.imageUrl.Url(icon: model.weather.first?.icon ?? ""))
        do{
            let d = try Data(contentsOf: url!)
            iconImageView.image = UIImage(data: d)
        } catch {
            return
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
