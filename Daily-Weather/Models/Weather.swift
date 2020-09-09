//
//  Weather.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
struct Weather  {
    var id : Int
    var main : String
    var description : String
    var icon : String
    
   enum Weather: String, CodingKey {
       case id = "id"
       case main = "main"
       case description = "description"
       case icon = "icon"

   }
}

extension Weather: Decodable {
   init(from decoder: Decoder) throws {
       let weatherContainer = try decoder.container(keyedBy: Weather.self)
       id = try weatherContainer.decode(Int.self, forKey: .id)
       main = try weatherContainer.decode(String.self, forKey: .main)
       description = try weatherContainer.decode(String.self, forKey: .description)
       icon = try weatherContainer.decode(String.self, forKey: .icon)
   }
}
