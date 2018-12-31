//
//  HomeTestViewController.swift
//  ism
//
//  Created by DAS on 10/29/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Cartography

protocol Reloadable {
    func reloadAfterInternetConnectionEstablished()
}

class HomeVC: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var home: [Home] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(collectionView)
        collectionView.backgroundColor = .clear

        automaticallyAdjustsScrollViewInsets = false

        home = [
            Home(title: "Library", icon:  UIImage(named: "library"), position: 1),
            Home(title: "Applicant", icon: UIImage(named: "profiles"), position: 2),
            Home(title: "Contacts", icon: UIImage(named: "student"), position: 3),
            Home(title: "Shedule", icon: UIImage(named: "shedule"), position: 4),
            Home(title: "Passport and visa procedure", icon: UIImage(named: "passport"), position: 5),
            Home(title: "ISM Student Council", icon: UIImage(named: "training"), position: 6),
            Home(title: "Events", icon: UIImage(named: "calendar"), position: 7),
            Home(title: "Video", icon: UIImage(named: "video"), position: 8),
            Home(title: "Air Ticket", icon: UIImage(named: "tickets"), position: 9),
            Home(title: "Taxi", icon: UIImage(named: "taxi"), position: 10)
        ]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return home.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellHome = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! CollectionViewCell
        cellHome.item = home[indexPath.item]
        cellHome.layer.borderColor = UIColor.lightGray.cgColor
        cellHome.layer.borderWidth = 0.5
        return cellHome
        
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height = UIScreen.main.bounds.size.width/2/3+20+12+40+20
        if UIDevice.current.userInterfaceIdiom == .pad {
            height += 12
        }
        
        return CGSize.init(width: UIScreen.main.bounds.size.width/2 - 15, height: height)
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
        if (self.home[indexPath.item].position == 1) {
            
            let libraryVC = UIStoryboard(name: "LibraryVC", bundle: nil).instantiateInitialViewController() as! LibraryVC
            let navC = UINavigationController(rootViewController: libraryVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 2){
        
            let applicantVC = UIStoryboard(name: "ApplicantVC", bundle: nil).instantiateInitialViewController() as! ApplicantVC
            let navC = UINavigationController(rootViewController: applicantVC)
            
            self.present(navC, animated: true, completion: nil)

        } else if (self.home[indexPath.item].position == 3) {
            
            let contactsVC = UIStoryboard(name: "ContactsVC", bundle: nil).instantiateInitialViewController() as! ContactsVC
            let navC = UINavigationController(rootViewController: contactsVC)
            
            self.present(navC, animated: true, completion: nil)

        } else if (self.home[indexPath.item].position == 4) {
            
            let scheduleVC = UIStoryboard(name: "ScheduleVC", bundle: nil).instantiateInitialViewController() as! ScheduleVC
            let navC = UINavigationController(rootViewController: scheduleVC)
            
            self.present(navC, animated: true, completion: nil)
        
        } else if (self.home[indexPath.item].position == 5) {
            
            let passportVC = UIStoryboard(name: "PassportVC", bundle: nil).instantiateInitialViewController() as! PassportVC
            let navC = UINavigationController(rootViewController: passportVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 6) {
            
            let ismStudentVC = UIStoryboard(name: "IsmStudentVC", bundle: nil).instantiateInitialViewController() as! IsmStudentVC
            let navC = UINavigationController(rootViewController: ismStudentVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if(self.home[indexPath.item].position == 8){
            
            let videoVC = UIStoryboard(name: "VideoVC", bundle: nil).instantiateInitialViewController() as! VideoVC
            let navC = UINavigationController(rootViewController: videoVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 9) {
            
            let ticketVC = UIStoryboard(name: "TicketVC", bundle: nil).instantiateInitialViewController() as! TicketVC
            let navC = UINavigationController(rootViewController: ticketVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 10) {
            
            let taxiVC = UIStoryboard(name: "TaxiVC", bundle: nil).instantiateInitialViewController() as! TaxiVC
            let navC = UINavigationController(rootViewController: taxiVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 7) {
            
            let eventsDetailVC = UIStoryboard(name: "EventsDetailVC", bundle: nil).instantiateInitialViewController() as! EventsDetailVC
            let navC = UINavigationController(rootViewController: eventsDetailVC)
            
            self.present(navC, animated: true, completion: nil)
            
        }
        
    
    }

}
