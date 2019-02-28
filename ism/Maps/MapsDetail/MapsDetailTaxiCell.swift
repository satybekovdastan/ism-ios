//
//  MapsDetailBodyCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/26/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class MapsDetailTaxiCell: UICollectionViewCell {
    
    var newTaxi: NewTaxi? {
        didSet {
            labelName.text = newTaxi?.title
            subLabelName.text = newTaxi?.phone_number
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mapsImageView)
        addSubview(labelName)
        addSubview(subLabelName)
        
        constrain(mapsImageView, labelName, subLabelName) { mapsImageView, labelName, subLabelName in
            
            mapsImageView.left == mapsImageView.superview!.left + 25
            mapsImageView.top == mapsImageView.superview!.top + 25
            mapsImageView.width == 20
            mapsImageView.height == 20
            
            labelName.bottom == mapsImageView.centerY
            labelName.left == mapsImageView.right + 35
            labelName.right == labelName.superview!.right - 16
            labelName.height == 24
            
            subLabelName.top == mapsImageView.centerY
            subLabelName.left == mapsImageView.right + 35
            subLabelName.right == subLabelName.superview!.right - 16
            subLabelName.height == 20
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mapsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "campusDetailTaxi")?.withRenderingMode(.alwaysOriginal)
        iv.image = image
        
        return iv
    }()
    
    let labelName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 16)
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        
        return lbl
    }()
    
    let subLabelName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 14)
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        
        return lbl
    }()
}
