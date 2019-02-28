//
//  NewsCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/23/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class NewsCell: UICollectionViewCell {
    
    var event: Event? {
        didSet {
            backgroundImageView.sd_setImage(with: URL(string: event!.image))
            titleLabel.text = event?.title
            descriptionLabel.attributedText = try! NSAttributedString(data: event!.description.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView.addSubview(titleLabel)
        textView.addSubview(descriptionLabel)
        
        constrain(titleLabel, descriptionLabel) { titleLabel, descriptionLabel in
            titleLabel.left == titleLabel.superview!.left
            titleLabel.top == titleLabel.superview!.top
            titleLabel.right == titleLabel.superview!.right
            titleLabel.height == 45
            
            descriptionLabel.left == descriptionLabel.superview!.left
            descriptionLabel.top == titleLabel.bottom
            descriptionLabel.right == descriptionLabel.superview!.right
            descriptionLabel.height == 55
        }
        
        addSubview(backgroundImageView)
        addSubview(arrowImageView)
        addSubview(textView)
        
        constrain(arrowImageView, backgroundImageView, textView) { arrowImageView, backgroundImageView, textView in
            
            arrowImageView.right == arrowImageView.superview!.right - 20
            arrowImageView.bottom == arrowImageView.superview!.bottom - 15
            arrowImageView.width == 24
            arrowImageView.height == 24
            
            backgroundImageView.left == backgroundImageView.superview!.left
            backgroundImageView.right == backgroundImageView.superview!.right
            backgroundImageView.top == backgroundImageView.superview!.top
            backgroundImageView.bottom == backgroundImageView.superview!.bottom
            
            textView.centerY == textView.superview!.centerY
            textView.centerX == textView.superview!.centerX
            textView.width == textView.superview!.width - 60
            textView.height == 100
            
            //            titleLabel.top == titleLabel.superview!.top + 30
            //            titleLabel.left == titleLabel.superview!.left + 30
            //            titleLabel.right == titleLabel.superview!.right - 30
            //
            //            descriptionLabel.top == titleLabel.bottom
            //            descriptionLabel.left == descriptionLabel.superview!.left + 30
            //            descriptionLabel.right == descriptionLabel.superview!.right - 30
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let arrowImageView: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "newsArrow")?.withRenderingMode(.alwaysOriginal)
        iv.image = image
        
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    let backgroundImageView: UIImageView = {
        
        let iv = UIImageView()
        let image = UIImage(named: "newsDefaultBackgroundImage")
        
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoMedium, size: 18)
        lbl.textColor = .white
        
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    let descriptionLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoMedium, size: 16)
        lbl.textColor = .white
        
        lbl.numberOfLines = 3
        
        return lbl
    }()
    
    let textView: UIView = {
        let view = UIView()
        
        return view
    }()
    
}
