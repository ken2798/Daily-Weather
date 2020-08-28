//
//  CoordinateData.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/28/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
import CoreLocation

struct CoordinateData {
    static var coor = CoordinateData()
    var lat : CLLocationDegrees = 0.0
    var lon : CLLocationDegrees = 0.0
    var locationManager = CLLocationManager()
}

extension CoordinateData {
    public mutating func updateCoor() {
        guard let managerCoor = locationManager.location?.coordinate else {return}
        let currentLocation: CLLocationCoordinate2D = managerCoor
        self.lon = currentLocation.longitude
        self.lat = currentLocation.latitude
    }
}
