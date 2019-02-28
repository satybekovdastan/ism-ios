//
//  CouncilCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/26/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class CouncilCell: UICollectionViewCell {
    
    var council: Council? {
        didSet {
            councilImageView.sd_setImage(with: URL(string: council!.image))
//            textLabel.text = council?.text
            var attrStr = try! NSAttributedString(
                data: council!.text.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            textLabel.attributedText = attrStr
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(councilImageView)
        addSubview(textLabel)
        
        constrain(councilImageView, textLabel) { councilImageView, textLabel in
            councilImageView.top == councilImageView.superview!.top
            councilImageView.left == councilImageView.superview!.left
            councilImageView.right == councilImageView.superview!.right
            councilImageView.height == 250
            
            textLabel.top == councilImageView.bottom + 25
            textLabel.left == textLabel.superview!.left + 16
            textLabel.right == textLabel.superview!.right - 16
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let councilImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let textLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 14)
        
        return lbl
    }()
}
