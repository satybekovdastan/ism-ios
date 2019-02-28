//
//  CampusDetail.swift
//  ism
//
//  Created by Atay Sultangaziev on 1/31/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class CampusDetail: UIViewController {
    
    var campus: NewCampus? {
        didSet {
            
            self.nameLabel.text = campus?.name
            self.homeLabel.text = campus?.address
            if campus?.phone_number != "" || campus?.additional_phone_number1 != "" {
                self.constrainPhone()
                self.phoneLabel.text = campus?.phone_number
                self.additionalPhoneLabel.text = campus?.additional_phone_number1
            }
            
            if campus?.email != "" {
                self.constrainMail()
                self.mailLabel.text = campus?.email
            }
            
        }
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        setupViews()
        setupNavBar()
        
    }
    
    func setupViews() {
        
        view.addSubview(containerView)
        
        constrain(containerView) { containerView in
            containerView.centerX == containerView.superview!.centerX
            containerView.centerY == containerView.superview!.centerY
            containerView.width == containerView.superview!.width - 32
            containerView.height == containerView.width
        }
        
        constrainHome()
        
    }
    
    func constrainPhone() {
        
        containerView.addSubview(phoneImageView)
        containerView.addSubview(phoneLabel)
        containerView.addSubview(additionalPhoneLabel)
        
        constrain(phoneImageView, phoneLabel, additionalPhoneLabel) { phoneImageView, phoneLabel, additionalPhoneLabel in
            
            phoneImageView.top == phoneImageView.superview!.top + 82
            phoneImageView.left == phoneImageView.superview!.left + 16
            phoneImageView.height == 25
            phoneImageView.width == 25
            
            phoneLabel.top == phoneImageView.top
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
        containerView.addSubview(mailLabel)
        containerView.addSubview(mailImageView)
        
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
    
    func constrainHome() {
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(homeImageView)
        containerView.addSubview(homeLabel)
        
        constrain(nameLabel, homeImageView, homeLabel) { nameLabel, homeImageView, homeLabel in
            
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(homeLabelTapped))
        homeLabel.addGestureRecognizer(tap)
        
    }
    
    @objc func homeLabelTapped() {
        print("Hello")
    }
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    let homeImageView: UIImageView = {
        
        var iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    let homeLabel: UILabel = {
        
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.isUserInteractionEnabled = true
        
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
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    
    
    
    
    
    
}
