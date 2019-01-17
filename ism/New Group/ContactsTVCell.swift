//
//  StudentTableViewCell.swift
//  ism
//
//  Created by DAS on 12/17/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class ContactsTVCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!

    func setupCell(item:Student) {
        self.selectionStyle = .none
        self.nameLabel.text = item.name
        self.positionLabel.text = item.position
        self.numberLabel.text = item.number
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.positionLabel.text = nil
        self.numberLabel.text = nil
    }
   
}
