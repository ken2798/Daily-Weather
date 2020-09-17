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
    var hourlyModels = [Hourly]()
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
        getWeatherData()
    }

    func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getWeatherData () {
        CoordinateData.coor.updateCoor()
        WeatherData.weather.fetchCoursesJSON(with: CoordinateData.coor.lon, lat: CoordinateData.coor.lat, completion: { [weak self] (res) in
            switch res {
            case .success(let result):
                self?.hourlyModels = result.hourly
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_) :
                return
            }
        })
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
