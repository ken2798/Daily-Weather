//
//  AddLocationTableViewCell.swift
//  Daily Weather
//
//  Created by Nguyen Tien Cong on 9/7/20.
//  Copyright © 2020 Nguyen Tien Cong. All rights reserved.
//

import UIKit

protocol AddLocationTableViewCellProtocol {
    func navigateToAnotherScreen()
    func ChangeTempType()
}

class AddLocationTableViewCell: UITableViewCell {
    
    
    @IBOutlet private weak var changeTempButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!
    var delegate : AddLocationTableViewCellProtocol?
    
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
        delegate?.navigateToAnotherScreen()
    }
    
    @IBAction func changeButtonAction(_ sender: UIButton) {
        delegate?.ChangeTempType()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
