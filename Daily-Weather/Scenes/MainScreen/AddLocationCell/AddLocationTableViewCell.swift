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
    @IBOutlet weak var changeTempButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .black
        addButton.setImage(UIImage(named: "plus.png"), for: .normal)
        
    }
    
    static let identifier = "AddLocationTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "AddLocationTableViewCell",
                     bundle: nil)
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        deelegate?.MoveTo()
    }
    
    @IBAction func changeButtonAction(_ sender: UIButton) {
        deelegate?.ChangeTemp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
