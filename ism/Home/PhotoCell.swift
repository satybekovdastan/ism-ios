//
//  PhotoCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 1/4/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class PhotoCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "home_image"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "launchScreenLogo"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        constrain(imageView) { imageView in
            imageView.left == imageView.superview!.left
            imageView.right == imageView.superview!.right
            imageView.top == imageView.superview!.top
            imageView.bottom == imageView.superview!.bottom
        }
        
        addSubview(logoImageView)
        constrain(logoImageView) { logoImageView in
            logoImageView.centerX == logoImageView.superview!.centerX
            logoImageView.centerY == logoImageView.superview!.centerY - 30
            logoImageView.height == 115
            logoImageView.width == 140
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
