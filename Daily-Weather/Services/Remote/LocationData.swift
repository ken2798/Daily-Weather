//
//  LocationData.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/28/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationData {
    static var location = LocationData()
}

extension LocationData {
    public func getAddressFromLatLon(lat : CLLocationDegrees, lon : CLLocationDegrees, cityCompletion: @escaping (String?, Error?) -> ()) {
        let ceo: CLGeocoder = CLGeocoder()
        let loc: CLLocation = CLLocation(latitude: lat, longitude: lon)
        var addressString = ""
        ceo.reverseGeocodeLocation(loc) { (placemarks, error) in
            guard let placemark = placemarks else {return}
            let pm = placemark as [CLPlacemark]
            if pm.count > 0 {
                let pm = placemark[0]
                if let localityy = pm.locality {
                    addressString = addressString + localityy
                    cityCompletion(addressString,nil)
                }
            }
        }
    }
}
