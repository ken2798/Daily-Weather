//
//  HourlyTableViewCell.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 9/9/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var models = [Hourly]()
    var currentModels : Current?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        collectionView.register(WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.getCurrentWeather()
    }
    
    static let identifier = "HourlyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyTableViewCell", bundle: nil)
    }
    
    func configure(with models: [Hourly]) {
        self.models = models
        collectionView.reloadData()
    }
    
    func getCurrentWeather(){
        CoordinateData.coor.updateCoor()
        let lat = CoordinateData.coor.lat
        let lon = CoordinateData.coor.lon
        WeatherData.weather.fetchCoursesJSON(with: lon, lat: lat, completion: {(res) in
            switch res {
            case .success(let result) :
                self.currentModels = result.current
            case .failure(_) :
                print("loi")
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 100)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
            guard let cr = currentModels else { return cell }
            cell.configure1(with: cr)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        cell.timeLabel.text = String(indexPath.row)
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
}
