//
//  EventCollectionViewCell.swift
//  ism
//
//  Created by DAS on 12/13/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!

    func initCell(item: Event) {
        title.text = item.title
        date.text = item.date

        self.imageView.sd_setImage(with: URL.init(string: item.image), completed: nil)

        //        labelDate.text = item.date
        //        if item.check == false {
        //            self.checkbox.setImage(UIImage(named: "circle.png"), for: .normal)
        //        }else{
        //            self.checkbox.setImage(UIImage(named: "circle.png"), for: .normal)
        //        }
    }
}
