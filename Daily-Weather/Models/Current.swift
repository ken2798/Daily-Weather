//
//  Current.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

struct Current : Codable {
    var dt: Int
    var sunRise: Int
    var sunSet: Int
    var temperature: Float
    var feelsLike: Float
    var pressure: Float
    var humidity: Float
    var dewPoint: Float
    var uvi: Float
    var clouds: Float
    var visibility: Float
    var windSpeed: Float
    var windDeg: Float
    var weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunRise = "sunrise"
        case sunSet = "sunset"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case uvi = "uvi"
        case clouds = "clouds"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather = "weather"
      
    }  
}


