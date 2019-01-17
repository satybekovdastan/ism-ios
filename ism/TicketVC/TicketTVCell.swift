//
//  TicketTableViewCell.swift
//  ism
//
//  Created by DAS on 11/21/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class TicketTVCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneLabel2: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    
    var item: Tickets? {
        didSet {
            self.selectionStyle = .none
            self.phoneLabel.text = item?.phone_number
            self.phoneLabel2.text = item?.additional_phone_number1
            self.emailLabel.text = item?.email
            self.siteLabel.text = item?.url
            self.itemImage.sd_setImage(with: URL.init(string: "\(item!.banner)"), completed: nil)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(phoneLabelTapped))
            phoneLabel.isUserInteractionEnabled = true
            phoneLabel.addGestureRecognizer(tap)
            
            let phoneLabel2Tap = UITapGestureRecognizer(target: self, action: #selector(phoneLabel2Tapped))
            phoneLabel2.isUserInteractionEnabled = true
            phoneLabel2.addGestureRecognizer(phoneLabel2Tap)
        }
    }
    
    @objc func phoneLabelTapped(sender:UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + "\(phoneLabel.text!.replacingOccurrences(of: " ", with: ""))") else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func phoneLabel2Tapped(_ sender: UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + "\(phoneLabel2.text!.replacingOccurrences(of: " ", with: ""))") else { return }
        UIApplication.shared.open(number)
    }

}
