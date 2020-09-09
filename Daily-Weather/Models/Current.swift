//
//  Current.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

struct Current {
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
    
    enum Current: String, CodingKey {
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

extension Current: Decodable {
    init(from decoder: Decoder) throws {
        let currentContainer = try decoder.container(keyedBy: Current.self)
        dt = try currentContainer.decode(Int.self, forKey: .dt)
        sunRise = try currentContainer.decode(Int.self, forKey: .sunRise)
        sunSet = try currentContainer.decode(Int.self, forKey: .sunSet)
        temperature = try currentContainer.decode(Float.self, forKey: .temperature)
        feelsLike = try currentContainer.decode(Float.self, forKey: .feelsLike)
        pressure = try currentContainer.decode(Float.self, forKey: .pressure)
        humidity = try currentContainer.decode(Float.self, forKey: .humidity)
        dewPoint = try currentContainer.decode(Float.self, forKey: .dewPoint)
        uvi = try currentContainer.decode(Float.self, forKey: .uvi)
        clouds = try currentContainer.decode(Float.self, forKey: .clouds)
        visibility = try currentContainer.decode(Float.self, forKey: .visibility)
        windDeg = try currentContainer.decode(Float.self, forKey: .windDeg)
        windSpeed = try currentContainer.decode(Float.self, forKey: .windSpeed)
        weather = try currentContainer.decode([Weather].self, forKey: .weather)
       
        
    }
}


