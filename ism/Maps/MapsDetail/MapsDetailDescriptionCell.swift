//
//  MapsDetailHeaderCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/26/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class MapsDetailDescriptionCell: UICollectionViewCell {
    
    var campus: NewCampus? {
        didSet {
            label.text = campus?.description
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        constrain(label) { label in
            label.left == label.superview!.left + 20
            label.right == label.superview!.right - 20
            label.centerY == label.superview!.centerY
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var label: UILabel = {
        
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 14)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
}
