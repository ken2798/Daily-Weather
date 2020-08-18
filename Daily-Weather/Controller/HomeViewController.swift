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
    
    var dailyModels = [Daily]()
    var hourlyModels = [Hourly]()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var current: Current?
    
    override func viewDidLoad() {
        
        table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        
        table.dataSource = self
        table.delegate = self
        

        requestWeatherForLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    //Location
    func setupLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func requestWeatherForLocation(){
        guard let currentLocation: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        let lon = currentLocation.longitude
        let lat = currentLocation.latitude
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&%20exclude=daily&appid=051eccdec971db6541e789fd524cfb66"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {
            data, response, error in
            //validation
            guard let data = data, error == nil else {
                print("something is wrong")
                return
            }
            //Covert data to models/some object
            var json: DataWeather?
            do {
                json = try JSONDecoder().decode(DataWeather.self, from: data)
            }
            catch {
                print("error: \(error)")
            }
            guard let result = json else {
                return
            }
            print(result.lat)
            print(result.lon)
            // Update user interface
            DispatchQueue.main.async {
                self.table.reloadData()            }
            }).resume()
    }

    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 1 cell that is collectiontableviewcell
            return 1
        }
        return dailyModels.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}

