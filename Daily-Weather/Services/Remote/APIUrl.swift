//
//  APIUrl.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/28/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
import CoreLocation

struct APIUrl {
    static let baseUrl : String = "https://api.openweathermap.org/data/2.5/onecall?lat=\(CoordinateData.coor.lat)&lon=\(CoordinateData.coor.lon)&%20exclude=daily&appid=051eccdec971db6541e789fd524cfb66"
}

