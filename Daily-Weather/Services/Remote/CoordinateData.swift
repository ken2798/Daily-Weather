//
//  CoordinateData.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/28/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
import CoreLocation

final class CoordinateData {
    static var coor = CoordinateData()
    var lat : CLLocationDegrees = 0.0
    var lon : CLLocationDegrees = 0.0
    var locationManager = CLLocationManager()
}

extension CoordinateData {
    public func updateCoor() {
        let currentLocation: CLLocationCoordinate2D = locationManager.location!.coordinate
        lon = currentLocation.longitude
        lat = currentLocation.latitude
    }
}
