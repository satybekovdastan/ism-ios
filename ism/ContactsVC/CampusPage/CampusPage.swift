//
//  CampusPage.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/21/19.
//  Copyright © 2019 sunrise. All rights reserved.

import UIKit
import Cartography
import Toast_Swift

class CampusPage: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, Reloadable {
    
    var id: Int?
    
    var contact = [ContactCampus]()
    
    let bodyCellId = "bodyCellId"
    let headerCellId = "headerCellId"
    
    func reloadAfterInternetConnectionEstablished() {
        getContact(id: id!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        getContact(id: id!)
        
    }
    
    func getContact(id: Int) {
        view.makeToastActivity(.center)
        ApiInteractor.shared.getContact(withId: id) { (response, errString) in
            if errString == nil {
                if let data = response {
                    self.contact = data
                    self.setupViews()
                    self.navigationItem.title = "\(self.contact[0].name)"
                }
            } else {
                self.internetErrorAlert(message: errString, reloadable: self)
            }
        }
    }
    
    func setupViews() {
        
        collectionView.register(CampusBodyCell.self, forCellWithReuseIdentifier: bodyCellId)
        collectionView.register(CampusHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        
        view.addSubview(collectionView)
        
        constrain(collectionView) { collectionView in
            
            collectionView.left == collectionView.superview!.left
            collectionView.top == collectionView.superview!.top
            collectionView.right == collectionView.superview!.right
            collectionView.bottom == collectionView.superview!.bottom
            
        }
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .white
        
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contact[0].roles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contact[0].roles[section].contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyCellId, for: indexPath) as! CampusBodyCell
        cell.contact = contact[0].roles[indexPath.section].contacts[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 94)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as! CampusHeaderCell
        cell.titleLabelText = contact[0].roles[indexPath.section].title
        
        if indexPath.section == 0 {
            cell.upperlineView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let url = URL(string: "tel://\(contact[0].roles[indexPath.section].contacts[indexPath.item].number)") {
            UIApplication.shared.open(url)
        }
    }
}
