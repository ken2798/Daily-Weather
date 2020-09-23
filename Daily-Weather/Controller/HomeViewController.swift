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
    @IBOutlet private weak var currentTempLb: UILabel!
    @IBOutlet private weak var currentLocationLb: UILabel!
    @IBOutlet private weak var currentStatusLb: UILabel!
    
    var hourlyModels = [Hourly]()
    var currentModels: Current?
    
    var latHome: CLLocationDegrees?
    var lonHome: CLLocationDegrees?
    let locationManager = CLLocationManager()
    let numberOfRowHourly:Int = 1
    let heightForRowAtHourly: CGFloat = 100.0
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        setupTableView()
        setupLocation()
        guard let lat = latHome else { return }
        guard let lon = lonHome else { return }
        getWeatherData(lat: lat, lon: lon)
        setupCurrentView(lat: lat, lon: lon)
    }
    
    func setupTableView(){
        tableView.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        tableView.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        CoordinateData.coor.updateCoor()
        latHome = CoordinateData.coor.lat
        lonHome = CoordinateData.coor.lon
    }
    
    func getWeatherData (lat : CLLocationDegrees, lon: CLLocationDegrees) {
        CoordinateData.coor.updateCoor()
        WeatherData.weather.fetchCoursesJSON(with: lon, lat: lat){ [weak self] (res) in
            switch res {
            case .success(let result):
                self?.hourlyModels = result.hourly
                self?.currentModels = result.current
                guard let cr = self?.currentModels else { return }
                DispatchQueue.main.async {
                    self?.currentTempLb.text = " \(Int(cr.temperature)-273)°"
                    self?.currentStatusLb.text = cr.weather[0].description
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func setupCurrentView(lat : CLLocationDegrees, lon: CLLocationDegrees){
        LocationData.location.getAddressFromLatLon(lat: lat, lon: lon){[weak self] (addressString, err) in
            if let addressString = addressString {
                self?.currentLocationLb.text = addressString
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
        guard let cr = currentModels else { return cell }
        cell.configure(current: cr, perHours: hourlyModels)
        return cell
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAtHourly
    }
}
