//
//  AcademicsBodyCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/22/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class AcademicsBodyCell: UICollectionViewCell {
    
    var item: Academics? {
        didSet {
            imageView.image = item?.icon
            label.text = item?.title
            rightImageView.image = item?.rightImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        leftView.addSubview(imageView)
        leftView.addSubview(label)
        
        constrain(imageView, label) { imageView, label in
            
            imageView.top == imageView.superview!.top + 21
            imageView.left == imageView.superview!.left + 62
            imageView.right == imageView.superview!.right - 62
            imageView.height == 56
            
            label.top == imageView.bottom
            label.left == label.superview!.left
            label.right == label.superview!.right
            label.bottom == label.superview!.bottom
            
        }
        
        let leftViewHeight = UIScreen.main.bounds.size.width/2/3+20+12+40+20
        let leftViewWidth = UIScreen.main.bounds.size.width/2 - 33
        
        addSubview(leftView)
        addSubview(rightImageView)
        
        constrain(leftView, rightImageView) { leftView, rightImageView in
            
            leftView.centerY == leftView.superview!.centerY
            leftView.left == leftView.superview!.left + 25
            leftView.height == leftViewHeight
            leftView.width == leftViewWidth
            
            rightImageView.centerY == rightImageView.superview!.centerY
            rightImageView.left == leftView.right - 10
            rightImageView.right == rightImageView.superview!.right - 25
            rightImageView.height == leftViewHeight - 20
            
        }
        
        bringSubviewToFront(leftView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .center
        
        return iv
    }()
    
    let label: UILabel = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoMedium, size: 12)
        lbl.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let leftView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        view.layer.masksToBounds = false
        
//        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
//        view.layer.shadowOpacity = 1
//        view.layer.shadowRadius = 6
//        view.layer.shadowOffset = CGSize(width: 0, height: 3)
//
//        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
//        view.layer.shouldRasterize = true
//
//        view.layer.rasterizationScale = UIScreen.main.scale
        
        return view
    }()
    
    let rightImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        
        return iv
    }()
    
}
