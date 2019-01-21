//
//  MapsCVCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 1/17/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class MapsCVCell: UICollectionViewCell {

    var item: Contact? {
        didSet {
            
            self.nameLabel.text = item?.name
            self.homeLabel.text = item?.address
            if item?.phone_number != "" || item?.additional_phone_number1 != "" {
                self.constrainPhone()
                self.phoneLabel.text = item?.phone_number
                self.additionalPhoneLabel.text = item?.additional_phone_number1
            }
            
            if item?.email != "" {
                self.constrainMail()
                self.mailLabel.text = item?.email
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(homeImageView)
        addSubview(homeLabel)
        
        constrain(nameLabel, separatorView, homeImageView, homeLabel) { nameLabel, separatorView, homeImageView, homeLabel in
            
            nameLabel.left == nameLabel.superview!.left + 16
            nameLabel.top == nameLabel.superview!.top + 16
            nameLabel.width == nameLabel.superview!.width - 32
            nameLabel.height == 20
            
            homeImageView.top == nameLabel.bottom + 16
            homeImageView.left == nameLabel.left
            homeImageView.height == 25
            homeImageView.width == 25
            
            homeLabel.centerY == homeImageView.centerY
            homeLabel.left == homeImageView.right + 16
            homeLabel.right == homeLabel.superview!.right - 16
            homeLabel.height == 25
            
        }
        
        addSubview(separatorView)
        
        constrain(separatorView) { separatorView in
            separatorView.bottom == separatorView.superview!.bottom
            separatorView.left == separatorView.superview!.left + 16
            separatorView.right == separatorView.superview!.right - 16
            separatorView.height == 1
        }
        
        self.contentView.heightAnchor.constraint(equalToConstant: 50)
        self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTapGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(phoneCall))
        phoneLabel.isUserInteractionEnabled = true
        phoneLabel.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(additionalPhoneCall))
        additionalPhoneLabel.isUserInteractionEnabled = true
        additionalPhoneLabel.addGestureRecognizer(tap)
    }
    
    @objc func phoneCall() {
        guard let number = URL(string: "tel://" + (item?.phone_number)!) else {return}
        UIApplication.shared.open(number)
    }
    
    @objc func additionalPhoneCall() {
        guard let number = URL(string: "tel://" + (item?.additional_phone_number1)!) else {return}
        UIApplication.shared.open(number)
    }
    
    func constrainPhone() {
        addSubview(phoneImageView)
        addSubview(phoneLabel)
        addSubview(additionalPhoneLabel)
        
        constrain(phoneImageView, phoneLabel, additionalPhoneLabel) { phoneImageView, phoneLabel, additionalPhoneLabel in
            
            phoneImageView.top == phoneImageView.superview!.top + 82
            phoneImageView.left == phoneImageView.superview!.left
            phoneImageView.height == 25
            phoneImageView.width == 25
            
            phoneLabel.top == phoneImageView.superview!.top
            phoneLabel.left == phoneImageView.right + 16
            phoneLabel.right == phoneLabel.superview!.right - 16
            phoneLabel.height == 12
            
            additionalPhoneLabel.left == phoneLabel.left
            additionalPhoneLabel.right == phoneLabel.right
            additionalPhoneLabel.bottom == phoneImageView.bottom
            additionalPhoneLabel.height == 12
            
        }
    }
    
    func constrainMail() {
        addSubview(mailLabel)
        addSubview(mailImageView)
        
        constrain(mailLabel, mailImageView) { mailLabel, mailImageView in
            
            mailImageView.top == mailImageView.superview!.top + 112
            mailImageView.left == mailImageView.superview!.left + 16
            mailImageView.width == 25
            mailImageView.height == 25
            
            mailLabel.centerY == mailImageView.centerY
            mailLabel.left == mailImageView.right + 16
            mailLabel.right == mailLabel.superview!.right - 16
            mailLabel.height == 12
            
        }
    }
    
    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    var homeImageView: UIImageView = {
        
        var iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit

        return iv
        
    }()
    
    var homeLabel: UILabel = {
        
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    let phoneImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "phone")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    let phoneLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    let additionalPhoneLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    let mailImageView: UIImageView = {
        
        var iv = UIImageView()
        iv.image = UIImage(named: "mail")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    let mailLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    
    
}




