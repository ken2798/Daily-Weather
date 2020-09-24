//
//  AddLocationTableViewCell.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/7/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

protocol AddLocationTableViewCellProtocol {
    func MoveTo()
    func ChangeTemp()
}

class AddLocationTableViewCell: UITableViewCell {
    
    var deelegate : AddLocationTableViewCellProtocol?
    @IBOutlet weak var changeTemBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .black
        addBtn.setImage(UIImage(named: "plus.png"), for: .normal)
        
    }
    
    static let identifier = "AddLocationTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "AddLocationTableViewCell",
                     bundle: nil)
    }
    
    @IBAction func addActBtn(_ sender: UIButton) {
        deelegate?.MoveTo()
    }
    
    @IBAction func changeActBtn(_ sender: UIButton) {
        deelegate?.ChangeTemp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
