//
//  UIViewControllerNavBar.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/27/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupNavBar() {
        let backItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backItemTapped))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
        navigationItem.title = "ISM"
    }
    
    @objc func backItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
