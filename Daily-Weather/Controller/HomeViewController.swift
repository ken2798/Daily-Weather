//
//  HomeViewController.swift
//  WeatherAppProject1
//
//  Created by Nguyen Tien Cong on 8/5/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var currentTempLb: UILabel!
    @IBOutlet weak var currentLocationLb: UILabel!
    @IBOutlet weak var currentStatusLb: UILabel!
    
    var hourlyModels = [Hourly]()
    var currentModels: Current?
    
    var latHome: CLLocationDegrees?
    var lonHome: CLLocationDegrees?
    let locationManager = CLLocationManager()
    let numberOfRowHourly:Int = 1
    let heightForRowAtHourly: CGFloat = 100.0
    
    override func viewDidLoad() {
        tableView.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        tableView.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        tableView.dataSource = self
        tableView.delegate = self
        setupLocation()
        guard let lat = latHome else {return}
        guard let lon = lonHome else {return}
        getWeatherData(lat: lat, lon: lon)
        setupCurrentView(lat: lat, lon: lon)
    }
    
    func setupLocation(){
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        CoordinateData.coor.updateCoor()
        latHome = CoordinateData.coor.lat
        lonHome = CoordinateData.coor.lon
    }
    
    func getWeatherData (lat : CLLocationDegrees, lon: CLLocationDegrees) {
        CoordinateData.coor.updateCoor()
        WeatherData.weather.fetchCoursesJSON(with: lon, lat: lat) { [weak self] (res) in
            switch res {
            case .success(let result):
                self?.hourlyModels = result.hourly
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func setupCurrentView(lat : CLLocationDegrees, lon: CLLocationDegrees){
        LocationData.location.getAddressFromLatLon(lat: lat, lon: lon){ (addressString, err) in
            if let addressString = addressString {
                self.currentLocationLb.text = addressString
            }
        }
        WeatherData.weather.fetchCoursesJSON(with: lon, lat: lat){(res) in
            switch res {
            case .success(let result) :
                self.currentModels = result.current
                guard let cr = self.currentModels else {return}
                DispatchQueue.main.async {
                    self.currentTempLb.text = " \(Int(cr.temperature)-273)°"
                    self.currentStatusLb.text = cr.weather[0].description
                }
            case .failure(let error) :
                print(error)
                return
            }
        }
    }
}

extension HomeViewController : CLLocationManagerDelegate {
    
}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowHourly
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as? HourlyTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: hourlyModels)
        return cell
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAtHourly
    }
}
