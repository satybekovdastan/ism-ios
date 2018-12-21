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
    
    func initCell(item: Home) {
        label.text = item.title
        imageView.image = item.icon
        //        labelDate.text = item.date
        //        if item.check == false {
        //            self.checkbox.setImage(UIImage(named: "circle.png"), for: .normal)
        //        }else{
        //            self.checkbox.setImage(UIImage(named: "circle.png"), for: .normal)
        //        }
    }
}
