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
    static let api = APIUrl()
    private let baseUrl : String = "https://api.openweathermap.org/data/2.5"
}

extension APIUrl {
    public func Url( lat : CLLocationDegrees, lon : CLLocationDegrees ) -> String {
        let url = baseUrl + "/onecall?lat=\(String(lat))&lon=\(String(lon))&%20exclude=daily&appid=\(KeyApi.key)"
        return url
    }
}
