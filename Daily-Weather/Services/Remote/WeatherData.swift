//
//  WeatherData.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 8/28/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
import CoreLocation

final class WeatherData {
    static var weather = WeatherData()
}
extension WeatherData {
    public func fetchCoursesJSON( with lon : CLLocationDegrees, lat : CLLocationDegrees, completion: @escaping (Result<DataWeather, Error>) -> ()) {
            let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&%20exclude=daily&appid=051eccdec971db6541e789fd524cfb66"
            URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {
                    data, response, error in
                    guard let data = data, error == nil else {
                        print("something is wrong")
                        completion(.failure(error!))
                        return
                    }
                    var json: DataWeather?
                    do {
                        json = try JSONDecoder().decode(DataWeather.self, from: data)
                        completion(.success(json!))
                    }
                    catch {
                        print("error: \(error)")
                    }
                    }).resume()
            }
}
