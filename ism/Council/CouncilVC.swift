//
//  CouncilVC.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/26/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography
import Toast_Swift

class CouncilVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Reloadable {
    
    func reloadAfterInternetConnectionEstablished() {
        getCouncil()
    }
    
    let councilCellId = "councilCellId"
    
    var councils = [Council]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Council"
        setupNavBar()
        
        collectionView.register(CouncilCell.self, forCellWithReuseIdentifier: councilCellId)
        
        getCouncil()
        
    }
    
    func getCouncil() {
        view.makeToastActivity(.center)
        ApiInteractor.shared.getCouncil { (response, errString) in
            self.view.hideToastActivity()
            if errString == nil {
                if let data = response {
                    self.councils = data
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
            collectionView.left == collectionView.superview!.left
            collectionView.right == collectionView.superview!.right
            collectionView.top == collectionView.superview!.top
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
        return councils.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: councilCellId, for: indexPath) as! CouncilCell
        cell.council = councils[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let attrStr = try! NSAttributedString(data: councils[indexPath.item].text.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        let size = CGSize(width: collectionView.frame.width - 32, height: .greatestFiniteMagnitude)
        let boundingBox = attrStr.boundingRect(
            with: size,
            options: [.usesLineFragmentOrigin, .usesFontLeading, .usesDeviceMetrics],
            context: nil
        )
//        let string = NSString(string: councils[indexPath.item].text).boundingRect(with: CGSize(width: collectionView.bounds.width - 40, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 14)], context: nil)
        
        return CGSize(width: collectionView.bounds.width, height: boundingBox.height + 275)
    }
    
}
