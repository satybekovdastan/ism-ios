//
//  MapsDetailVC.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/26/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class MapsDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let firstSectionCellId = "firstSectionCellId"
    let descriptionCellId = "descriptionCellId"
    let secondSectionTaxiCellId = "secondSectionTaxiCellId"
    let thirdSectionAirCellId = "thirdSectionAirCellId"
    
    var contactCampus: ContactCampus?
    var campus: NewCampus? {
        didSet {
            setupNavBar()
            navigationItem.title = campus?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        collectionView.register(MapsDetailContactsCell.self, forCellWithReuseIdentifier: firstSectionCellId)
        collectionView.register(MapsDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellId)
        collectionView.register(MapsDetailTaxiCell.self, forCellWithReuseIdentifier: secondSectionTaxiCellId)
        collectionView.register(MapsDetailAirCell.self, forCellWithReuseIdentifier: thirdSectionAirCellId)
        
        
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
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            return contactCampus!.taxis.count
        }
        return contactCampus!.air_tickets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstSectionCellId, for: indexPath) as! MapsDetailContactsCell
                cell.labelName.text = campus?.address
                cell.mapsImageView.image = UIImage(named: "campusDetailLocation")
                return cell
            } else if indexPath.item == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstSectionCellId, for: indexPath) as! MapsDetailContactsCell
                cell.labelName.text = campus?.phone_number
                cell.mapsImageView.image = UIImage(named: "campusGreenPhone")
                return cell
            } else if indexPath.item == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstSectionCellId, for: indexPath) as! MapsDetailContactsCell
                cell.labelName.text = campus?.email
                cell.mapsImageView.image = UIImage(named: "campusDetailMessage")
                return cell
            } else if indexPath.item == 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellId, for: indexPath) as! MapsDetailDescriptionCell
                cell.campus = campus
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondSectionTaxiCellId, for: indexPath) as! MapsDetailTaxiCell
            cell.newTaxi = contactCampus?.taxis[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thirdSectionAirCellId, for: indexPath) as! MapsDetailAirCell
        cell.newAir = contactCampus?.air_tickets[indexPath.item]
        return cell
        
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if indexPath.item == 0 || indexPath.item == 1 || indexPath.item == 2 {
                return CGSize(width: collectionView.bounds.width, height: 60)
            } else if indexPath.item == 3 {
                let string = NSString(string: campus!.description).boundingRect(with: CGSize(width: collectionView.bounds.width, height: 1000), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 14)], context: nil)
                return CGSize(width: collectionView.bounds.width, height: string.height)
            }
        } else if indexPath.section == 1 {
            return CGSize(width: collectionView.bounds.width, height: 64)
        }
        return CGSize(width: collectionView.bounds.width, height: 64)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            if indexPath.item == 0 {

                let vc = MapInternal()
                vc.campus = campus
                navigationController?.pushViewController(vc, animated: true)

            } else if indexPath.item == 1 {

                if let url = URL(string: "tel://\(campus!.phone_number.replacingOccurrences(of: " ", with: ""))") {
                    UIApplication.shared.open(url)
                }

            } else if indexPath.item == 2 {

            } else if indexPath.item == 3 {

            }
            
        } else if indexPath.section == 1 {
            print("section1")
            if let url = URL(string: "tel://\(contactCampus!.taxis[indexPath.item].phone_number.replacingOccurrences(of: " ", with: ""))") {
                UIApplication.shared.open(url)
            }
        } else if indexPath.section == 2 {
            
            if let url = URL(string: "tel://\(contactCampus!.air_tickets[indexPath.item].phone_number.replacingOccurrences(of: " ", with: ""))") {
                UIApplication.shared.open(url)
            }
        }
        
        
    }
    
}
