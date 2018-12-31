//
//  EventCollectionViewCell.swift
//  ism
//
//  Created by DAS on 12/13/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class EventsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!

    
    var item: Event? {
        didSet {
            title.text = item!.title
            date.text = item!.date
            self.imageView.sd_setImage(with: URL.init(string: item!.image), completed: nil)
        }
    }
}
