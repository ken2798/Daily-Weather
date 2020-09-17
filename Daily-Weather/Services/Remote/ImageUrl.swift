//
//  ImageUrl.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 9/14/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
import CoreLocation

struct ImageUrl {
    static let imageUrl = ImageUrl()
    private let baseUrl : String = "https://openweathermap.org/img/w/"
}

extension ImageUrl {
    public func Url(icon : String) -> String {
        let url = baseUrl + (icon) + ".png"
        return url
    }
}
