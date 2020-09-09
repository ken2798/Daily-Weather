//
//  FeelsLike.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

struct FeelsLike  {
    var day: Float
    var night: Float
    var evening: Float
    var morning: Float
  
    enum FeelsLike: String, CodingKey {
           case day = "day"
           case night = "night"
           case evening = "eve"
           case morning = "morn"

       }
    }

extension FeelsLike: Decodable {
   init(from decoder: Decoder) throws {
       let feelsLikeContainer = try decoder.container(keyedBy: FeelsLike.self)
       day = try feelsLikeContainer.decode(Float.self, forKey: .day)
       night = try feelsLikeContainer.decode(Float.self, forKey: .night)
       evening = try feelsLikeContainer.decode(Float.self, forKey: .evening)
       morning = try feelsLikeContainer.decode(Float.self, forKey: .morning)
   }
}
