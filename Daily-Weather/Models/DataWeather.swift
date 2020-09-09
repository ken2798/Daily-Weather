//
//  DataWeather.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

struct DataWeather: Codable {
    var lat: Float
    var lon: Float
    var timeZone: String
    var timeZoneOffSet: Int
    var current: Current
    var hourly: [Hourly]
    var daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
        case timeZone = "timezone"
        case timeZoneOffSet = "timezone_offset"
        case current = "current"
        case hourly = "hourly"
        case daily = "daily"
    }
    
    
}

