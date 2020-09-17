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
    public func fetchCoursesJSON(with lon : CLLocationDegrees, lat : CLLocationDegrees, completion: @escaping (Result<DataWeather, Error>) -> ()) {
        guard let url = URL(string: APIUrl.api.Url(lat: lat, lon: lon) ) else { return }
        URLSession.shared.dataTask(with: url ) { data, response, error in
            guard let data = data, error == nil else {
                guard let err = error else {return}
                completion(.failure(err))
                return
            }
            var json: DataWeather?
            do {
                json = try JSONDecoder().decode(DataWeather.self, from: data)
                guard let js = json else {return}
                completion(.success(js))
            }
            catch {
                print("error: \(error)")
            }
        }.resume()
    }
}
