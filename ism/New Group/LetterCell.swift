//
//  LetterCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/21/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class LetterCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        addSubview(letterLabel)
        addSubview(checkImageView)
        
        constrain(letterLabel, checkImageView) { letterLabel, checkImageView in
            
            checkImageView.centerY == checkImageView.superview!.centerY
            checkImageView.left == checkImageView.superview!.left + 30
            checkImageView.width == 20
            checkImageView.height == 20
            
            letterLabel.centerY == letterLabel.superview!.centerY
            letterLabel.left == checkImageView.right + 14
            letterLabel.right == letterLabel.superview!.right - 16
            letterLabel.height == 16
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let letterLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 13)
        lbl.textColor = .black
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    let checkImageView: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "letterUnchecked")?.withRenderingMode(.alwaysOriginal)
        iv.image = image
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            checkImageView.image = UIImage(named: "letterChecked")?.withRenderingMode(.alwaysOriginal)
            NotificationCenter.default.post(name: .letterChecked, object: letterLabel.text)
        } else {
            checkImageView.image = UIImage(named: "letterUnchecked")?.withRenderingMode(.alwaysOriginal)
            NotificationCenter.default.post(name: .letterUnchecked, object: letterLabel.text)

        }
        
    }
}
