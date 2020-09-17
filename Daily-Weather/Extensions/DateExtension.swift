//
//  DateExtension.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 9/17/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation

extension Date {
    func getDayForDate(date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: inputDate) + ":00"
    }
}
