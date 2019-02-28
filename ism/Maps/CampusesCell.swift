//
//  CampusesCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/22/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class CampusesCell: UICollectionViewCell {
    
    var campus: NewCampus? {
        didSet {
            
            imageView.sd_setImage(with: URL(string: campus!.image))
            campusName.text = campus?.name
            address.text = campus?.address
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(campusName)
        addSubview(address)
        addSubview(underlineView)
        
        constrain(imageView, campusName, address, underlineView) { imageView, campusName, address, underlineView in
            
            imageView.left == imageView.superview!.left
            imageView.centerY == imageView.superview!.centerY
            imageView.height == 56
            imageView.width == 100
            
            campusName.top == campusName.superview!.top + 14
            campusName.left == imageView.right + 16
            campusName.right == campusName.superview!.right - 16
            campusName.height == 24
            
            address.top == campusName.bottom
            address.left == imageView.right + 16
            address.right == address.superview!.right - 16
            address.height == 40
            
            underlineView.bottom == underlineView.superview!.bottom
            underlineView.left == imageView.right + 16
            underlineView.right == underlineView.superview!.right
            underlineView.height == 1
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    let imageView: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "randomCampus")?.withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let campusName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 16)
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    let address: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 14)
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
        
        return view
    }()
    
}
