//
//  PassportViewController.swift
//  ism
//
//  Created by DAS on 12/17/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class PassportVC: UIViewController, Reloadable {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("It's me!")
        scrollView.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        self.getPassportAndVisa()
        self.setupNavBar()
    }
    
    func getPassportAndVisa() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getPassportVisa{ (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                if let data = response {
                    var items = [Passport]()
                    items = data;
                    self.label.attributedText = try! NSAttributedString(data: items[0].passport_and_visa_procedure.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
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
