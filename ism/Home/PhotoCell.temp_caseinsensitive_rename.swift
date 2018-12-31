//
//  photoCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/31/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Cartography

class PhotoCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bebe-rexha")
        
        return imageView
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
