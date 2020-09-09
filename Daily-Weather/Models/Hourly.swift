//
//  Hourly.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

struct Hourly {
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

extension Hourly: Decodable {
    init(from decoder: Decoder) throws {
        let hourlyContainer = try decoder.container(keyedBy: Hourly.self)
        dt = try hourlyContainer.decode(Int.self, forKey: .dt)
        temperature = try hourlyContainer.decode(Float.self, forKey: .temperature)
        feelsLike = try hourlyContainer.decode(Float.self, forKey: .feelsLike)
        pressure = try hourlyContainer.decode(Float.self, forKey: .pressure)
        humidity = try hourlyContainer.decode(Float.self, forKey: .humidity)
        dewPoint = try hourlyContainer.decode(Float.self, forKey: .dewPoint)
        visibility = try hourlyContainer.decode(Float.self, forKey: .visibility)
        clouds = try hourlyContainer.decode(Float.self, forKey: .clouds)
        windDeg = try hourlyContainer.decode(Float.self, forKey: .windDeg)
        windSpeed = try hourlyContainer.decode(Float.self, forKey: .windSpeed)
        weather = try hourlyContainer.decode([Weather].self, forKey: .weather)
    }
}

     
