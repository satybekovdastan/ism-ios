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
    @IBOutlet weak var phoneLabel2: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    var number:String = ""
    
    func setupCell(item:String, image:String, phone2:String, email:String, url:String) {
        self.selectionStyle = .none
        self.phoneLabel.text = item
        self.phoneLabel2.text = phone2
        self.emailLabel.text = email
        self.siteLabel.text = url
        
        self.itemImage.sd_setImage(with: URL.init(string: image), completed: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(TicketTVCell.tapFunction))
        number = item
        phoneLabel.isUserInteractionEnabled = true
        phoneLabel.addGestureRecognizer(tap)
        
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(number)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.phoneLabel.text = nil
        self.itemImage.image = nil
        self.phoneLabel2.text = nil
        self.emailLabel.text = nil
        self.siteLabel.text = nil
    }
}
