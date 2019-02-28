//
//  CampusBodyCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/21/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class CampusBodyCell: UICollectionViewCell {
    
    var contact: Contact? {
        didSet {
            phoneLabel.text = ""
            name.text = contact?.name
            phoneLabel.text = "\(contact!.position) \(contact!.number)"
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(phoneImageView)
        addSubview(name)
        addSubview(phoneLabel)
        
        constrain(phoneImageView, name, phoneLabel) { phoneImageView, name, phoneLabel in
            
            phoneImageView.left == phoneImageView.superview!.left + 24
            phoneImageView.centerY == phoneImageView.superview!.centerY
            phoneImageView.height == 21
            phoneImageView.width == 21
            
            name.top == name.superview!.top + 23
            name.left == phoneImageView.right + 34
            name.right == name.superview!.right - 16
            name.height == 24
            
            phoneLabel.top == name.bottom
            phoneLabel.left == phoneImageView.right + 34
            phoneLabel.right == phoneLabel.superview!.right - 16
            phoneLabel.height == 24
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let phoneImageView: UIImageView = {
        
        let iv = UIImageView()
        let image = UIImage(named: "campusGreenPhone")?.withRenderingMode(.alwaysOriginal)
        iv.image = image
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let name: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 16)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    let phoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 14)
        lbl.textAlignment = .left
        
        return lbl
    }()
}
