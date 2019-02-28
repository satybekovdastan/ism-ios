//
//  CampusHeaderCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/21/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class CampusHeaderCell: UICollectionViewCell {
    
    var titleLabelText: String? {
        didSet {
            titleLabel.text = titleLabelText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(underlineView)
        addSubview(upperlineView)
        
        constrain(titleLabel, underlineView, upperlineView) { titleLabel, underlineView, upperlineView in
            
            titleLabel.centerY == titleLabel.superview!.centerY
            titleLabel.left == titleLabel.superview!.left + 79
            titleLabel.right == titleLabel.superview!.right - 16
            titleLabel.height == 24
            
            underlineView.bottom == underlineView.superview!.bottom
            underlineView.left == underlineView.superview!.left + 20
            underlineView.right == underlineView.superview!.right - 20
            underlineView.height == 1
            
            upperlineView.top == upperlineView.superview!.top
            upperlineView.left == upperlineView.superview!.left + 20
            upperlineView.right == upperlineView.superview!.right - 20
            upperlineView.height == 1
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 18)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
        
        return view
    }()
    
    let upperlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
        
        return view
    }()
    
}
