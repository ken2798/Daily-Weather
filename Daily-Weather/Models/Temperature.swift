//
//  Temp.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

struct Temperature  {
    var day: Float
    var min: Float
    var max: Float
    var night: Float
    var evening: Float
    var morning: Float
    
    enum Temperature: String, CodingKey {
            case day = "day"
            case min = "min"
            case max = "max"
            case night = "night"
            case evening = "eve"
            case morning = "morn"

       }
    }

    extension Temperature: Decodable {
       init(from decoder: Decoder) throws {
           let temperatureContainer = try decoder.container(keyedBy: Temperature.self)
           day = try temperatureContainer.decode(Float.self, forKey: .day)
           night = try temperatureContainer.decode(Float.self, forKey: .night)
           min = try temperatureContainer.decode(Float.self, forKey: .min)
           max = try temperatureContainer.decode(Float.self, forKey: .max)
           evening = try temperatureContainer.decode(Float.self, forKey: .evening)
           morning = try temperatureContainer.decode(Float.self, forKey: .morning)
       }
    }

