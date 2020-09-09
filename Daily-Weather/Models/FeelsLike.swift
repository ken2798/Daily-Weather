//
//  FeelsLike.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

struct FeelsLike : Codable  {
    var day: Float
    var night: Float
    var evening: Float
    var morning: Float
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case night = "night"
        case evening = "eve"
        case morning = "morn"
        
    }
}
