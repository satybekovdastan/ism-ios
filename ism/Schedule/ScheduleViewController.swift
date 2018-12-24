//
//  ScheduleViewController.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/24/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBAction func okButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ListViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()! as! ListViewController
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
