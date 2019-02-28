//
//  MapsDetailAirCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/26/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class MapsDetailAirCell: UICollectionViewCell {
    
    var newAir: NewAir? {
        didSet {
            labelName.text = newAir?.title
            subLabelName.text = newAir?.phone_number
            emailLabel.text = newAir?.email
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        labelsView.addSubview(labelName)
        labelsView.addSubview(subLabelName)
        labelsView.addSubview(emailLabel)
        
        constrain(emailLabel, labelName, subLabelName) { emailLabel, labelName, subLabelName in
            
            labelName.top == labelName.superview!.top
            labelName.left == labelName.superview!.left
            labelName.right == labelName.superview!.right
            labelName.height == 24
            
            subLabelName.top == labelName.bottom
            subLabelName.left == subLabelName.superview!.left
            subLabelName.right == labelName.superview!.right
            subLabelName.height == 24
            
            emailLabel.top == subLabelName.bottom
            emailLabel.left == emailLabel.superview!.left
            emailLabel.right == emailLabel.superview!.right
            emailLabel.height == 20
            
        }
        
        addSubview(mapsImageView)
        addSubview(labelsView)
        
        constrain(mapsImageView, labelsView) { mapsImageView, labelsView in
            
            mapsImageView.left == mapsImageView.superview!.left + 25
            mapsImageView.top == mapsImageView.superview!.top + 25
            mapsImageView.width == 20
            mapsImageView.height == 20
            
            labelsView.left == mapsImageView.right + 35
            labelsView.right == labelsView.superview!.right - 16
            labelsView.centerY == mapsImageView.centerY
            labelsView.height == 68
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mapsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "campusDetailAir")?.withRenderingMode(.alwaysOriginal)
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
    
    let emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 14)
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        
        return lbl
    }()
    
    let labelsView: UIView = {
        let view = UIView()
        return view
    }()
}
