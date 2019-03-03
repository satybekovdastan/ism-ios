//
//  ContactsVC.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/20/19.
//  Copyright © 2019 sunrise. All rights reserved.

import UIKit
import Toast_Swift
import Cartography

class ContactsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, Reloadable {
    
    func reloadAfterInternetConnectionEstablished() {
        getContactCampuses()
    }
    
    let cellId = "cellId"
    
    var contactCampuses = [ContactCampus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ContactsCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavBar()
        navigationItem.title = "Contacts"
        getContactCampuses()
        
    }
    
    func getContactCampuses() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getContacts { (response, errorString) in
            self.view.hideToastActivity()
            
            if errorString == nil {
                if let data = response {
                    
                    self.contactCampuses = data
                    self.setupViews()
                    
                }
                
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
            
        }
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        
        constrain(collectionView) { collectionView in
            
            collectionView.top == collectionView.superview!.top
            collectionView.left == collectionView.superview!.left
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactsCell
        
        cell.contactCampus = contactCampuses[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactCampuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 102)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CampusPage()
        vc.id = contactCampuses[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
