//
//  HomeViewController.swift
//  WeatherAppProject1
//
//  Created by Nguyen Tien Cong on 8/5/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet var table: UITableView!
    
    var hourlyModels = [Hourly]()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        table.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        table.dataSource = self
        table.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
        getWeatherData()
    }
    
    func setupLocation(){
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getWeatherData () {
        CoordinateData.coor.updateCoor()
        WeatherData.weather.fetchCoursesJSON(with: CoordinateData.coor.lon, lat: CoordinateData.coor.lat, completion: {(res) in
            switch res {
            case .success(let result) :
                self.hourlyModels = result.hourly
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            case .failure(_) :
                print("loi")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
        cell.configure(with: hourlyModels)
        print(hourlyModels)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
