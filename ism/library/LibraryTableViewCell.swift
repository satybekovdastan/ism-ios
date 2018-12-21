//
//  LibraryTableViewCell.swift
//  ism
//
//  Created by DAS on 11/22/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {

   
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func setupCell(name:String, author:String, image:String) {
        self.selectionStyle = .none
        self.titleLabel.text = name
        self.authorLabel.text = author
        self.itemImage.sd_setImage(with: URL.init(string: image), completed: nil)
        
        self.itemImage.layer.borderWidth = 0.1
        self.itemImage.layer.masksToBounds = false
        self.itemImage.layer.borderColor = UIColor.lightGray.cgColor
        self.itemImage.layer.cornerRadius = self.itemImage.frame.height/2
        self.itemImage.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.authorLabel.text = nil
        self.itemImage.image = nil
    }


}
