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
        guard let url = URL(string: APIUrl.baseUrl ) else { return }
            URLSession.shared.dataTask(with: url ) {
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
                    }.resume()
            }
}
