//
//  ListLocationView.swift
//  Daily-Weather
//
//  Created by Nguyen Tien Cong on 9/24/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import RealmSwift
var checkTem: Bool = true

class BaseTableView : UITableView {
    var chageContentSize : ((_ size : CGSize)-> Void)?
    override var contentSize: CGSize {
        didSet {
            chageContentSize?(contentSize)
        }
    }
}

class ListLocationViewController : UIViewController {
    
    @IBOutlet var heighTableView: NSLayoutConstraint!
    @IBOutlet weak var listLocationTable: BaseTableView!
    
    var listCity = [City]()
    var passData: ((CLLocationDegrees,CLLocationDegrees) -> Void)?
    
    override func viewDidLoad() {
        getListLocation()
        setupTableView()
        view.backgroundColor = .black
    }
    
    func setupTableView() {
        listLocationTable.dataSource = self
        listLocationTable.delegate = self
        listLocationTable.backgroundColor = .black
        listLocationTable.chageContentSize = { (size) in
            self.heighTableView.constant = size.height
        }
        listLocationTable.isScrollEnabled = false
        listLocationTable.register(LocationTableViewCell.nib(), forCellReuseIdentifier: LocationTableViewCell.identifier)
        listLocationTable.register(AddLocationTableViewCell.nib(), forCellReuseIdentifier: AddLocationTableViewCell.identifier)
    }
    func getListLocation() {
        let realm = try! Realm()
        let results = realm.objects(City.self)
        listCity = Array(results)
    }
}

extension ListLocationViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listCity.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return .delete
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = listLocationTable.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as! LocationTableViewCell
            cell.configure(with: listCity[indexPath.row] )
            return cell
        }
            let cell = listLocationTable.dequeueReusableCell(withIdentifier: AddLocationTableViewCell.identifier, for: indexPath) as! AddLocationTableViewCell
            cell.deelegate = self
            return cell
    }
}

extension ListLocationViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if editingStyle == .delete {
                listLocationTable.beginUpdates()
                let realm = try! Realm()
                if let cityObject = realm.objects(City.self).filter("name ==  \'\(listCity[indexPath.row].name)\'").first {
                    try! realm.write {
                        realm.delete(cityObject)
                        listCity.remove(at: indexPath.row)
                    }
                }
                else{
                    return
                }
                listLocationTable.deleteRows(at: [indexPath] , with: .bottom)
                listLocationTable.endUpdates()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listLocationTable.deselectRow(at: indexPath, animated: true)
        passData?(listCity[indexPath.row].lat,listCity[indexPath.row].lon)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension ListLocationViewController: AddLocationTableViewCellProtocol {
    func MoveTo() {
    }
    
    func ChangeTemp() {
        if checkTem == true {
            checkTem = false
            listLocationTable.reloadData()
        } else {
            checkTem = true
            listLocationTable.reloadData()
        }
    }
}
