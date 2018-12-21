//
//  HomePageViewController.swift
//  Checkin
//
//  Created by Artem Kirnos on 12/12/17.
//  Copyright © 2017 sunriseStudio. All rights reserved.
//

import UIKit
import MXSegmentedPager

protocol Reloadable {
	func reloadAfterInternetConnectionEstablished()
}

class HomePageViewController: MXSegmentedPagerController, UITextFieldDelegate {
	
	static let storyboardId = "HomePageSB"
	static let reuseIdentifier = "HomePageViewController"
	
	@IBOutlet weak var topheaderView: NSLayoutConstraint!
	@IBOutlet weak var headerView: UIView!
	@IBOutlet weak var searchRoundView: RoundedView!
	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var searchButton: RoundedButton!
	
	var cancelFindTapGesture = UITapGestureRecognizer()
	var isFindTextFieldTyping = false
	
    override func viewDidLoad() {
		let customNav = self.navigationController as? BaseNavigationController
		customNav?.setNavButtonsAndLogo(forController: self)
		self.setAppearanceAndAddSubViews()
		super.viewDidLoad()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		self.cancelFind()
		super.viewDidDisappear(true)
	}
	
	func setAppearanceAndAddSubViews() {
		segmentedPager.backgroundColor = .white
		segmentedPager.bounces = false
		// Parallax Header
		let topHeigth = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
		segmentedPager.parallaxHeader.view = headerView
		segmentedPager.parallaxHeader.mode = .fill
		if #available(iOS 11.0, *) {
			// Running iOS 11 OR NEWER
			segmentedPager.parallaxHeader.height =  160
		} else {
			segmentedPager.parallaxHeader.height = topHeigth + 160
			// Earlier version of iOS
		}
		self.topheaderView.constant = topHeigth
		segmentedPager.parallaxHeader.minimumHeight = topHeigth + 65
				
		self.searchButton.backgroundColor = Colors.turquoise
		self.searchRoundView.dropShadow(color: .gray, opacity: 2, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
		// set find field
		self.searchTextField.delegate = self
		self.searchTextField.returnKeyType = UIReturnKeyType.search
	}
	
	override func heightForSegmentedControl(in segmentedPager: MXSegmentedPager) -> CGFloat {
		return 0
	}
	
	// MARK: - Search setup
	// MARK: - Textfield Delegate Find Items
	
	@IBAction func searchButtonTapped(_ sender: RoundedButton) {
		self.cancelFind()
	}
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		self.searchButton.setImage(UIImage.init(named: "crossWhite"), for: .normal)
		
		// dissmis keyboard on searchImageView tap
		self.cancelFindTapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelFind))
		self.view.addGestureRecognizer(self.cancelFindTapGesture)
		
		return true
	}
	
	@objc func cancelFind() {
		self.searchButton.setImage(UIImage.init(named: "searchWhite"), for: .normal)
		self.dismissKeyboard()
		self.searchTextField.text = nil
		self.view.removeGestureRecognizer(self.cancelFindTapGesture)
	}
	
	//When user press the return key in keyboard
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if !(textField.text?.isEmpty)! {
			self.sendFindPhraseToServer()
			self.dismissKeyboard()
		}
		return true
	}
	
	func sendFindPhraseToServer() {
		if !(self.searchTextField.text?.isEmpty)! {
			// swiftlint:disable force_cast
			let destinationVC = UIStoryboard.init(name: SpecialistInstitutionViewController.storyboardId, bundle: nil).instantiateInitialViewController() as! SpecialistInstitutionViewController
			// swiftlint:enable force_cast
			destinationVC.findPhrase = self.searchTextField.text!
			destinationVC.findTextField.isUserInteractionEnabled = false
			self.navigationController?.pushViewController(destinationVC, animated: true)
		}
	}
	
	func dismissKeyboard() {
		view.endEditing(true)
	}

}
