//
//  HomeTestViewController.swift
//  ism
//
//  Created by DAS on 10/29/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class EventsDetailVC: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Reloadable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var event = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        collectionView.isScrollEnabled = true
        self.getEvents()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupNavBar()
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
    
    
    func reloadAfterInternetConnectionEstablished() {
        self.getEvents()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return event.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellHome = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! EventsCVCell
        
        cellHome.item = event[indexPath.item]
        cellHome.layer.borderColor = UIColor.lightGray.cgColor
        cellHome.layer.borderWidth = 0.5
        
        return cellHome
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width/2 - 15, height: 270)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // horizontal
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // vertical
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let eventsDetailTVC = UIStoryboard(name: "EventsDetailTVC", bundle: nil).instantiateInitialViewController() as! EventsDetailTVC
        eventsDetailTVC.event = event[indexPath.item]
        let navC = UINavigationController(rootViewController: eventsDetailTVC)
        
        present(navC, animated: true, completion: nil)
    }
    
}
