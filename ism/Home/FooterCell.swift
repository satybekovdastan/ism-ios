//
//  FooterCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/12/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class FooterCell: UICollectionViewCell {
    
    var aboutUs: AboutUs?
    var downloadDelegate: DownloadProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        generalView.addSubview(infoButton)
        generalView.addSubview(facebookButton)
        generalView.addSubview(instagramButton)
        generalView.addSubview(youtubeButton)
        
        constrain(infoButton, facebookButton, instagramButton, youtubeButton) { infoButton, facebookButton, instagramButton, youtubeButton in
            
            infoButton.top == infoButton.superview!.top
            infoButton.left == infoButton.superview!.left
            infoButton.height == infoButton.superview!.height
            infoButton.width == 40
            
            facebookButton.top == facebookButton.superview!.top
            facebookButton.left == infoButton.right + 30
            facebookButton.height == facebookButton.superview!.height
            facebookButton.width == 40
            
            instagramButton.left == facebookButton.right + 30
            instagramButton.top == instagramButton.superview!.top
            instagramButton.height == facebookButton.superview!.height
            instagramButton.width == 40
            
            youtubeButton.left == instagramButton.right + 30
            youtubeButton.top == youtubeButton.superview!.top
            youtubeButton.height == youtubeButton.superview!.height
            youtubeButton.width == 40
            
        }
        
        addSubview(generalView)
        
        constrain(generalView) { generalView in
            generalView.centerX == generalView.superview!.centerX
            generalView.centerY == generalView.superview!.centerY
            generalView.width == 250
            generalView.height == 40
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let generalView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var infoButton: UIButton = {
        let bn = UIButton(type: .system)
        bn.backgroundColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1)
        //        bn.backgroundColor = .red
        bn.setImage(UIImage(named: "infoButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        bn.layer.cornerRadius = 20
        bn.layer.masksToBounds = true
        
        bn.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        return bn
        
    }()
    
    @objc func infoButtonTapped() {
        downloadDelegate?.downloadBook()
    }
    
    lazy var facebookButton: UIButton = {
        let bn = UIButton(type: .system)
        bn.backgroundColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1)
//        bn.backgroundColor = .red
        bn.setImage(UIImage(named: "facebook")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        bn.layer.cornerRadius = 20
        bn.layer.masksToBounds = true
        
        bn.addTarget(self, action: #selector(facebookButtonTapped), for: .touchUpInside)
        
        return bn
        
    }()
    
    @objc func facebookButtonTapped() {
        
        if let url = URL(string: "\(aboutUs!.facebook)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    lazy var instagramButton: UIButton = {
        let bn = UIButton(type: .system)
        bn.backgroundColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1)
        bn.setImage(UIImage(named: "instagram")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        bn.layer.cornerRadius = 20
        bn.layer.masksToBounds = true
        
        bn.addTarget(self, action: #selector(instagramButtonTapped), for: .touchUpInside)
        
        return bn
    }()
    
    @objc func instagramButtonTapped() {
        print("instagram tapped")
        if let url = URL(string: "\(aboutUs!.instagram)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    lazy var youtubeButton: UIButton = {
        let bn = UIButton(type: .system)
        bn.backgroundColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1)
        bn.setImage(UIImage(named: "youtube")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        bn.layer.cornerRadius = 20
        bn.layer.masksToBounds = true
        
        bn.addTarget(self, action: #selector(youtubeButtonTapped), for: .touchUpInside)
        
        return bn
    }()
    
    @objc func youtubeButtonTapped() {
        if let url = URL(string: "\(aboutUs!.youtube_url)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
