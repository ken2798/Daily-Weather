//
//  Hourly.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

struct Hourly : Codable {
    var dt: Int
    var temperature: Float
    var feelsLike: Float
    var pressure: Float
    var humidity: Float
    var dewPoint: Float
    var clouds: Float
    var visibility: Float
    var windSpeed: Float
    var windDeg: Float
    var weather: [Weather]
    
    enum Hourly: String, CodingKey {
        case dt = "dt"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case visibility = "visibility"
        case clouds = "clouds"
        case windDeg = "wind_deg"
        case windSpeed = "wind_speed"
        case weather = "weather"
    }   
}

     
