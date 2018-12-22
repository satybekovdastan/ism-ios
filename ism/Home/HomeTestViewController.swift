//
//  HomeTestViewController.swift
//  ism
//
//  Created by DAS on 10/29/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
protocol Reloadable {
    func reloadAfterInternetConnectionEstablished()
}

class HomeTestViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var home: [Home] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false

        home = [
            Home(title: "Library", icon:  UIImage(named: "library"), position: 1),
            Home(title: "Applicant", icon: UIImage(named: "profiles"), position: 2),
            Home(title: "Student", icon: UIImage(named: "student"), position: 3),
            Home(title: "Shedule", icon: UIImage(named: "shedule"), position: 4),
            Home(title: "Passport and visa procedure", icon: UIImage(named: "passport"), position: 5),
            Home(title: "ISM STUDENT Counsil", icon: UIImage(named: "training"), position: 6),
            Home(title: "Events", icon: UIImage(named: "calendar"), position: 7),
            Home(title: "Video", icon: UIImage(named: "video"), position: 8),
            Home(title: "Ticket Air", icon: UIImage(named: "tickets"), position: 9),
            Home(title: "Ticket Taxi", icon: UIImage(named: "taxi"), position: 10)
        ]
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        var layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

//        layout.minimumInteritemSpacing = 5
//        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return home.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellHome = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! CollectionViewCell
        
        cellHome.item = home[indexPath.item]
        cellHome.layer.borderColor = UIColor.lightGray.cgColor
        cellHome.layer.borderWidth = 0.5

        print("ITEM (asd)")
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
        if(self.home[indexPath.item].position==1){
            let newVC = storyboard?.instantiateViewController(withIdentifier:"cellLibrary") as! LibraryViewController
            navigationController?.pushViewController(newVC, animated: true)
        }else if(self.home[indexPath.item].position==2){
            let backItem = UIBarButtonItem()
            backItem.title = ""
            backItem.tintColor = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
            navigationItem.backBarButtonItem = backItem
            let newVC = storyboard?.instantiateViewController(withIdentifier:"cellApplicant") as! ApplicantViewController
            navigationController?.pushViewController(newVC, animated: true)
        }else if(self.home[indexPath.item].position==3){
            let newVC = storyboard?.instantiateViewController(withIdentifier:"cellStudent") as! StudentViewController
            navigationController?.pushViewController(newVC, animated: true)
        }else if(self.home[indexPath.item].position==5){
            let newVC = storyboard?.instantiateViewController(withIdentifier:"cellPassport") as! PassportViewController
            navigationController?.pushViewController(newVC, animated: true)
        }else if(self.home[indexPath.item].position==6){
            let newVC = storyboard?.instantiateViewController(withIdentifier:"cellIsmStudent") as! IsmStudentViewController
            navigationController?.pushViewController(newVC, animated: true)
        }else if(self.home[indexPath.item].position==8){
            let newVC = storyboard?.instantiateViewController(withIdentifier:"cellVideo") as! VideoViewController
            navigationController?.pushViewController(newVC, animated: true)
        }else if(self.home[indexPath.item].position==9){
            let newVC = storyboard?.instantiateViewController(withIdentifier:"cellTicket") as! TicketViewController
            navigationController?.pushViewController(newVC, animated: true)
        }else if(self.home[indexPath.item].position==10){
            let newVC = storyboard?.instantiateViewController(withIdentifier:"cellTaxi") as! TaxiViewController
            navigationController?.pushViewController(newVC, animated: true)
        }else if(self.home[indexPath.item].position==7){
            let newVC = storyboard?.instantiateViewController(withIdentifier:"cellEvent") as! EventsViewController
            navigationController?.pushViewController(newVC, animated: true)
        }
        
    
    }

}
