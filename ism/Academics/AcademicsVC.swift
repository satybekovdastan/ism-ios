//
//  AcademicsVC.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/22/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class AcademicsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Reloadable {
    
    func reloadAfterInternetConnectionEstablished() {
        getEvents()
    }
    
    let bodyId = "bodyId"
    let headerId = "headerId"
    
    var event = [Event]()
    
    let home = [
        Academics(title: "Library", icon: UIImage(named: "library"), rightImage: UIImage(named: "libraryRightImage"), position: 1),
        Academics(title: "Schedule", icon: UIImage(named: "schedule"), rightImage: UIImage(named: "scheduleRightImage"), position: 1),
        Academics(title: "News", icon: UIImage(named: "news"), rightImage: UIImage(named: "newsRightImage"), position: 1)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heightOfStatusBar = UIApplication.shared.statusBarFrame.height
        collectionView.contentInset = UIEdgeInsets(top: -heightOfStatusBar, left: 0, bottom: 0, right: 0)
        
        collectionView.register(AcademicsBodyCell.self, forCellWithReuseIdentifier: bodyId)
        collectionView.register(AcademicsHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(collectionView)
        
        constrain(collectionView) { collectionView in
            collectionView.top == collectionView.superview!.top
            collectionView.left == collectionView.superview!.left
            collectionView.right == collectionView.superview!.right
            collectionView.bottom == collectionView.superview!.bottom
        }
        
        view.addSubview(backButton)
        
        constrain(backButton) { backButton in
            
            backButton.left == backButton.superview!.left + 15
            backButton.top == backButton.superview!.top + 30
            backButton.width == 8
            backButton.height == 13
            
        }
    }
    
    func getEvents() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getEvents{ (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                if let data = response {
                    self.event = data
                    self.collectionView.reloadData()
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        }
    }
    
    func addBlurEffect() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        threeButtonsView.addSubview(libraryButton)
        threeButtonsView.addSubview(booksButton)
        threeButtonsView.addSubview(physicButton)
        
        constrain(libraryButton, booksButton, physicButton) { libraryButton, booksButton, physicButton in
            
            libraryButton.top == libraryButton.superview!.top
            libraryButton.left == libraryButton.superview!.left
            libraryButton.right == libraryButton.superview!.right
            libraryButton.height == 36
            
            booksButton.top == libraryButton.bottom + 34
            booksButton.left == booksButton.superview!.left
            booksButton.right == booksButton.superview!.right
            booksButton.height == 36
            
            physicButton.top == booksButton.bottom + 34
            physicButton.left == physicButton.superview!.left
            physicButton.right == physicButton.superview!.right
            physicButton.height == 36
            
        }
        
        blurEffectView.contentView.addSubview(threeButtonsView)
        
        constrain(threeButtonsView) { threeButtonsView in
            
            threeButtonsView.centerY == threeButtonsView.superview!.centerY
            threeButtonsView.left == threeButtonsView.superview!.left + 44
            threeButtonsView.right == threeButtonsView.superview!.right - 44
            threeButtonsView.height == 176
            
        }
        
        
        
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blurEffectTapped)))
        
    }
    
    @objc func blurEffectTapped(_ sender: UITapGestureRecognizer) {
        let view = sender.view!
        view.removeFromSuperview()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    lazy var backButton: UIButton = {
        
        let bn = UIButton(type: .system)
        bn.setBackgroundImage(UIImage(named: "backButton"), for: .normal)
        
        bn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return bn
    }()
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    let libraryButton: UIButton = {
        
        let bn = UIButton(type: .system)
        bn.setAttributedTitle(NSAttributedString(string: "LIBRARY", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoMedium, size: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)]), for: .normal)
        bn.backgroundColor = .white
        
        return bn
        
    }()
    
    let booksButton: UIButton = {
        
        let bn = UIButton(type: .system)
        bn.setAttributedTitle(NSAttributedString(string: "BOOKS", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoMedium, size: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)]), for: .normal)
        bn.backgroundColor = .white
        
        return bn
        
    }()
    
    let physicButton: UIButton = {
        
        let bn = UIButton(type: .system)
        bn.setAttributedTitle(NSAttributedString(string: "PHYSIC", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoMedium, size: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)]), for: .normal)
        bn.backgroundColor = .white
        
        return bn
        
    }()
    
    let threeButtonsView: UIView = {
        let view = UIView()
        return view
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return home.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyId, for: indexPath) as! AcademicsBodyCell
        cell.item = home[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as! AcademicsHeaderCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            addBlurEffect()
        }
        
        if indexPath.item == 1 {

            let scheduleVC = UIStoryboard(name: "ScheduleVC", bundle: nil).instantiateInitialViewController() as! ScheduleVC
            let navC = UINavigationController(rootViewController: scheduleVC)

            self.present(navC, animated: true, completion: nil)

        }
        
        if indexPath.item == 2 {
            let newsVC = NewsVC()
            let navC = UINavigationController(rootViewController: newsVC)
            present(navC, animated: true)
        }
        
    }
}
