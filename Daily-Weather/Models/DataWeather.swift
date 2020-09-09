//
//  DataWeather.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

struct DataWeather {
    var lat: Float
    var lon: Float
    var timeZone: String
    var timeZoneOffSet: Int
    var current: Current
    var hourly: [Hourly]
    var daily: [Daily]
    
    enum DataWeather: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
        case timeZone = "timezone"
        case timeZoneOffSet = "timezone_offset"
        case current = "current"
        case hourly = "hourly"
        case daily = "daily"
    }
    
    
}

extension DataWeather: Decodable {
    init(from decoder: Decoder) throws {
        let dataWeatherContainer = try decoder.container(keyedBy: DataWeather.self)
        lat = try dataWeatherContainer.decode(Float.self, forKey: .lat)
        lon = try dataWeatherContainer.decode(Float.self, forKey: .lon)
        timeZone = try dataWeatherContainer.decode(String.self, forKey: .timeZone)
        timeZoneOffSet = try dataWeatherContainer.decode(Int.self, forKey: .timeZoneOffSet)
        current = try dataWeatherContainer.decode(Current.self, forKey: .current)
        hourly = try dataWeatherContainer.decode([Hourly].self, forKey: .hourly)
        daily = try dataWeatherContainer.decode([Daily].self, forKey: .daily)
        
    }
}

