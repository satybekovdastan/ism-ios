//
//  HomePageViewCollectionViewController.swift
//  Checkin
//
//  Created by Artem Kirnos on 1/10/18.
//  Copyright © 2018 sunriseStudio. All rights reserved.
//

import UIKit

class HomePageViewCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Reloadable {

	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var topCollectionViewConstraint: NSLayoutConstraint!
	
	var items = [MainCategoriesObject]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.getCategories()
		self.collectionView.register(UINib.init(nibName: HomePageCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: HomePageCollectionViewCell.reuseIdentifier)
    }
	
	func getCategories() {
		ApiInteractor.shared.getMainCategoryItems { (response, errorString) in
			if errorString == nil {
				if let data = response {
					self.items = data
					self.collectionView.reloadData()
				}
			} else {
				self.internetErrorAlert(message: errorString, reloadable: self)
			}
		}
	}
	
	func reloadAfterInternetConnectionEstablished() {
		self.getCategories()
	}
	
	// MARK: - UICollectionViewDataSource
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		// swiftlint:disable force_cast
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageCollectionViewCell.reuseIdentifier, for: indexPath) as! HomePageCollectionViewCell
		// swiftlint:enable force_cast
		cell.setupCell(item: self.items[indexPath.item])
		return cell
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
		// swiftlint:disable force_cast
		let destinationVC = UIStoryboard.init(name: SpecialistInstitutionViewController.storyboardId, bundle: nil).instantiateViewController(withIdentifier: SpecialistInstitutionViewController.reuseIdentifier) as! SpecialistInstitutionViewController
		// swiftlint:enable force_cast
		destinationVC.categorySlug = self.items[indexPath.item].slug
		self.navigationController?.pushViewController(destinationVC, animated: true)
	}
}
