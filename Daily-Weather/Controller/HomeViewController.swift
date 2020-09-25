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
    
    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var currentLocationLabel: UILabel!
    @IBOutlet private weak var currentStatusLabel: UILabel!
    
    var latHome: CLLocationDegrees?
    var lonHome: CLLocationDegrees?
    var heighOfRow: CGFloat = 0
    var numberOfRow: Int = 0
    var dailyModels = [Daily]()
    var hourlyModels = [Hourly]()
    var currentModels: Current?
    let locationManager = CLLocationManager()
    let numberOfSection: Int = 4
    let heighOfSection: CGFloat = 1
    
    override func viewDidLoad() {
        menuButton.setImage(UIImage(named: "menu.png"), for: .normal)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        setupTableView()
        setupLocation()
        guard let lat = latHome else { return }
        guard let lon = lonHome else { return }
        getWeatherData(lat: lat, lon: lon)
        setupCurrentView(lat: lat, lon: lon)
    }
    
    @IBAction func viewListCityButtonAction(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "Home", bundle: nil ).instantiateViewController(withIdentifier: "ListLocationView") as? ListLocationViewController
            else {return}
        vc.passData = { [weak self] (latCity,lonCity) in
            self?.setupCurrentView(lat: latCity, lon: lonCity)
            self?.getWeatherData(lat: latCity, lon: lonCity)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupTableView(){
        tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        tableView.register(TodayDetailTableViewCell.nib(), forCellReuseIdentifier: TodayDetailTableViewCell.identifier)
        tableView.register(TodayInformationTableViewCell.nib(), forCellReuseIdentifier: TodayInformationTableViewCell.identifier)
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
                self?.dailyModels = result.daily
                guard let cr = self?.currentModels else { return }
                DispatchQueue.main.async {
                    self?.currentTempLabel.text = " \(Int(cr.temperature)-273)°"
                    self?.currentStatusLabel.text = cr.weather[0].description
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
                self?.currentLocationLabel.text = addressString
            }
        }
    }
}

extension HomeViewController : CLLocationManagerDelegate {
    
}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? dailyModels.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as? HourlyTableViewCell else {
                return UITableViewCell()
            }
            guard let cr = self.currentModels else { return cell }
            cell.configure(current: cr, perHours: hourlyModels)
            return cell
        }
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: dailyModels[indexPath.row])
            return cell
        }
        if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayDetailTableViewCell.identifier, for: indexPath) as? TodayDetailTableViewCell else {
                return UITableViewCell()
            }
            guard let cr = currentModels else { return cell }
            cell.configure(with: cr)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayInformationTableViewCell.identifier, for: indexPath) as? TodayInformationTableViewCell else {
            return UITableViewCell()
        }
        guard let cr = currentModels else { return cell }
        cell.configure(with: cr)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heighOfSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            heighOfRow = 100
            return heighOfRow
        case 1:
            heighOfRow = 50
            return heighOfRow
        case 2:
            heighOfRow = 100
            return heighOfRow
        case 3:
            heighOfRow = 423
            return heighOfRow
        default:
            return 0
        }
    }
}
