//
//  CollectionViewCell.swift
//  ism
//
//  Created by DAS on 10/29/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var item: Home? {
        didSet {
            guard let item = item else { return }
            
            label.text = item.title
            imageView.image = item.icon
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //custom logic goes here
    }
    
}
