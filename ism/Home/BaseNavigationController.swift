//
//  BaseNavigationController.swift
//  Checkin
//
//  Created by Artem Kirnos on 12/12/17.
//  Copyright © 2017 sunriseStudio. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setNavButtonsAndLogo(forController controller:UIViewController) {
        // set Navigation Items
        self.navigationBar.tintColor = UIColor.black
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        let favoritesButton = UIBarButtonItem.init(image: UIImage.init(named: "favorites"), style: UIBarButtonItem.Style.done, target: self, action: #selector(favoritesButtonTapped))
//        controller.navigationItem.rightBarButtonItem = favoritesButton
        
        let logo = UIImage(named: "checkinBarLogo")
        let imageView = UIImageView(image:logo)
        controller.navigationController?.navigationBar.backgroundColor = Colors.whiteGrayBackground
        controller.navigationItem.titleView = imageView
    }
    
//    @objc func favoritesButtonTapped() {
//        if !(navigationController?.topViewController is SpecialistsMainViewController) {
//            for vc in self.viewControllers {
//                if let myGropupVC = vc as? SpecialistsMainViewController {
//                    if myGropupVC.isFavorites == true {
//                        self.popToViewController(myGropupVC, animated: true)
//                        return
//                    }
//                }
//            }
//            //swiftlint:disable force_cast
//            let destinationVC = UIStoryboard.init(name: SpecialistsMainViewController.storyboardId, bundle: nil).instantiateViewController(withIdentifier: SpecialistsMainViewController.reuseIdentifier) as! SpecialistsMainViewController
//            destinationVC.isFavorites = true
//            //swiftlint:enable force_cast
//            self.pushViewController(destinationVC, animated: true)
//        }
//    }
}
