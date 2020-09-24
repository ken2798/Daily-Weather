//
//  City.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/7/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift

class City : Object {
    @objc dynamic var id = 0
    @objc dynamic var name : String = ""
    @objc dynamic var lat : CLLocationDegrees = 0
    @objc dynamic var lon : CLLocationDegrees = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
