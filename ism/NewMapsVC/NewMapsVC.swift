//
//  NewMapsVC.swift
//  ism
//
//  Created by Atay Sultangaziev on 1/31/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography
import Toast_Swift

class NewMapsVC: UIViewController, UIScrollViewDelegate, Reloadable {
    
    var campusItems = [NewCampus]()
    
    var campusesActionSheet = UIAlertController(title: "Campus", message: "Choose your campus", preferredStyle: .actionSheet)
    
    func reloadAfterInternetConnectionEstablished() {
        getCampuses()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setupNavBar()
        setupGestureRecognizers()
//        navigationController?.navigationBar.backgroundColor = .white
        getCampuses()
    }
    
    func setupViews() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 790)
        
        view.addSubview(scrollView)
        
        constrain(scrollView) { scrollView in
            scrollView.left == scrollView.superview!.left
            scrollView.right == scrollView.superview!.right
            scrollView.top == scrollView.superview!.safeAreaLayoutGuide.top
            scrollView.bottom == scrollView.superview!.bottom
        }
        
        scrollView.addSubview(chooseCampusLabel)
        
        constrain(chooseCampusLabel) { chooseCampusLabel in
            chooseCampusLabel.left == chooseCampusLabel.superview!.left + 16
            chooseCampusLabel.top == chooseCampusLabel.superview!.top + 16
            chooseCampusLabel.width == chooseCampusLabel.superview!.width - 32
            chooseCampusLabel.height == 16
        }
    }
    
    func setupGestureRecognizers() {
        let campusTap = UITapGestureRecognizer(target: self, action: #selector(chooseCampusTapped))
        chooseCampusLabel.addGestureRecognizer(campusTap)
    }
    
    @objc func chooseCampusTapped() {
        present(campusesActionSheet, animated: true)
    }
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        
        return v
    }()
    
    func getCampuses() {
        self.view.makeToastActivity(.center)
        
        ApiInteractor.shared.getCampuses { (response, errorString) in
            self.view.hideToastActivity()
            
            if errorString == nil {
                if let data = response {
                    
                    self.campusItems = data
                    for item in self.campusItems {
                        self.campusesActionSheet.addAction(UIAlertAction(title: "\(item.name)", style: .default, handler: { (action) in
                            self.chooseCampusLabel.text = item.name
                            let vc = CampusDetail()
                            for i in self.campusItems {
                                if i.name == self.chooseCampusLabel.text {
                                    vc.campus = i
                                }
                            }
                            
                            let navC = UINavigationController(rootViewController: vc)
                            self.present(navC, animated: true)
                        }))
                    }
                    self.campusesActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        }
    }
    
    let chooseCampusLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.isUserInteractionEnabled = true
        
        lbl.text = "Choose your campus"
        
        return lbl
    }()
    
}
