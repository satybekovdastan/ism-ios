//
//  MapsDetailCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/26/19.
//  Copyright © 2019 sunrise. All rights reserved.

import UIKit
import Cartography

class MapsDetailContactsCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mapsImageView)
        addSubview(labelName)

        constrain(mapsImageView, labelName) { mapsImageView, labelName in

            mapsImageView.left == mapsImageView.superview!.left + 25
            mapsImageView.top == mapsImageView.superview!.top + 25
            mapsImageView.width == 20
            mapsImageView.height == 20

            labelName.left == mapsImageView.right + 35
            labelName.centerY == mapsImageView.centerY
            labelName.right == labelName.superview!.right - 16
            labelName.height == 23

        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let mapsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit

        return iv
    }()

    let labelName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 14)
        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)

        return lbl
    }()

}
