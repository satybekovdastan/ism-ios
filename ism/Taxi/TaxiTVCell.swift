//
//  TaxiTableViewCell.swift
//  ism
//
//  Created by DAS on 11/26/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class TaxiTVCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var phoneNumber: String = ""
    
    var item: Tickets? {
        didSet {
            self.phoneLabel.text = item?.phone_number
            self.emailLabel.text = item?.email
            self.itemImage.sd_setImage(with: URL.init(string: "\(item!.banner)"), completed: nil)
            self.selectionStyle = .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(phoneLabelTapped))
        phoneLabel.addGestureRecognizer(tap)
    }
    
    @objc func phoneLabelTapped(_ sender: UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + "\(phoneLabel.text!.replacingOccurrences(of: " ", with: ""))") else {
            return
        }
        UIApplication.shared.open(number)
    }
    
}
