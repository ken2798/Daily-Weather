//
//  LocationTableViewCell.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/6/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var TemperatureLabel: UILabel!
    
    var curr : Current?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        // Initialization code
    }
    
    static let identifier = "LocationTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "LocationTableViewCell",
                     bundle: nil)
    }
    
    func configure(with city: City) {
        self.locationLabel.text = city.name
        WeatherData.weather.fetchCoursesJSON(with: city.lon, lat: city.lat, completion: { [weak self] (res) in
            switch res {
            case .success(let result) :
                self?.curr = result.current
                DispatchQueue.main.async {
                    guard let cur = self?.curr else {return}
                    self?.timeLabel.text = Date(timeIntervalSince1970: Double(cur.dt)).getExTime()
                    if checkTemp == false {
                        self?.TemperatureLabel.text = "\((Int(cur.temperature)-273))°C"
                    }
                    else {
                        self?.TemperatureLabel.text = "\((Int(cur.temperature)*9/5-458))°F"
                    }
                }
            case .failure(let error) :
                print(error)
            }
        })
        
    }
}
