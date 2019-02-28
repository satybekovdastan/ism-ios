//
//  Maps.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/22/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class Maps: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, Reloadable {
    
    var campuses = [NewCampus]()
    var contactCampuses = [ContactCampus]()
    
    let cellId = "cellId"
    
    func reloadAfterInternetConnectionEstablished() {
        getCampuses()
        getContactCampuses()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CampusesCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavBar()
        navigationItem.title = "Maps"
        
        getCampuses()
        getContactCampuses()
        
    }
    
    func getCampuses() {
        ApiInteractor.shared.getCampuses { (response, errString) in
            if errString == nil {
                if let data = response {
                    self.campuses = data
                    self.setupViews()
                    
                }
            } else {
                self.internetErrorAlert(message: errString, reloadable: self)
            }
        }
    }
    
    func getContactCampuses() {
        ApiInteractor.shared.getContacts { (response, errString) in
            if errString == nil {
                if let data = response {
                    self.contactCampuses = data
                    self.setupViews()
                    
                }
            } else {
                self.internetErrorAlert(message: errString, reloadable: self)
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CampusesCell
        
        cell.campus = campuses[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 102)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MapsDetailVC()
        vc.campus = campuses[indexPath.item]
        vc.contactCampus = contactCampuses[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
