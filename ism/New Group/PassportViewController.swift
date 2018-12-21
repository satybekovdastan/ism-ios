//
//  PassportViewController.swift
//  ism
//
//  Created by DAS on 12/17/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class PassportViewController: UIViewController, Reloadable {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        self.getPassportAndVisa()
    }
    

    func getPassportAndVisa() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getPassportVisa{ (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                if let data = response {
                    var items = [Passport]()
                    items = data;
                    self.label.text = items[0].passport_and_visa_procedure.htmlToString
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        }
    }
    
    func reloadAfterInternetConnectionEstablished() {
        self.getPassportAndVisa()
    }

}
