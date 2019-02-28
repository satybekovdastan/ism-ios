//
//  AcademicsHeaderCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/22/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class AcademicsHeaderCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headerImageView.addSubview(academicsLabel)
        
        constrain(academicsLabel) { academicsLabel in
            academicsLabel.centerY == academicsLabel.superview!.centerY
            academicsLabel.centerX == academicsLabel.superview!.centerX
            academicsLabel.width == 160
            academicsLabel.height == 38
        }
        
        addSubview(headerImageView)
        
        constrain(headerImageView) { headerImageView in
            
            headerImageView.top == headerImageView.superview!.top
            headerImageView.left == headerImageView.superview!.left
            headerImageView.right == headerImageView.superview!.right
            headerImageView.bottom == headerImageView.superview!.bottom
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerImageView: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "academicsHeaderImage")
        iv.image = image
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let academicsLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.text = "Academics"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Roboto-Medium", size: 32)
        lbl.textAlignment = .center
        
        return lbl
        
    }()
    
}
