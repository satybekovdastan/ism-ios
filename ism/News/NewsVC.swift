//
//  NewsVC.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/23/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class NewsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Reloadable {
    
    let cellId = "cellId"
    
    func reloadAfterInternetConnectionEstablished() {
        getEvents()
    }
    
    var news = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavBar()
        navigationItem.title = "News"
        
        getEvents()
        
    }
    
    func getEvents() {
        ApiInteractor.shared.getEvents { (response, errString) in
            if errString == nil {
                if let data = response {
                    self.news = data
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsCell
        
        cell.event = news[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let eventsDetailTVC = UIStoryboard(name: "EventsDetailTVC", bundle: nil).instantiateInitialViewController() as! EventsDetailTVC
        eventsDetailTVC.event = news[indexPath.item]
//        let navC = UINavigationController(rootViewController: eventsDetailTVC)
        navigationController?.pushViewController(eventsDetailTVC, animated: true)
//        present(navC, animated: true, completion: nil)
        
    }
    
}
