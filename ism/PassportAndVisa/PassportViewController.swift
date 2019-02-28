//
//  PassportViewController.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/27/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class PassportViewController: UIViewController, UIScrollViewDelegate, Reloadable {
    
    var passport = [Passport]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        navigationItem.title = "Passport and visa procedure"
        getPassportAndVisa()
        
    }
    
    func getPassportAndVisa() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getPassportVisa{ (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                if let data = response {
                    self.passport = data
                    self.setupViews()
                    self.setupTextView()
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        }
    }
    
    func setupTextView() {
        
        self.textView.attributedText = try! NSAttributedString(data: self.passport[0].passport_and_visa_procedure.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        
        let string = try! NSAttributedString(data: self.passport[0].passport_and_visa_procedure.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil).boundingRect(with: CGSize(width: self.view.frame.width - 32, height: 6000), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        textView.heightAnchor.constraint(equalToConstant: string.height).isActive = true
        scrollView.contentSize = CGSize(width: view.frame.width, height: string.height + 8)
    }
    
    func setupViews() {
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1500)
        
        view.addSubview(scrollView)
        
        constrain(scrollView, textView) { scrollView, textView in
            
            scrollView.top == scrollView.superview!.safeAreaLayoutGuide.top
            scrollView.left == scrollView.superview!.left
            scrollView.right == scrollView.superview!.right
            scrollView.bottom == scrollView.superview!.bottom
            
        }
        
        scrollView.addSubview(textView)
        
        constrain(textView) { textView in
            
            textView.top == textView.superview!.top
            textView.left == textView.superview!.left + 16
            textView.width == textView.superview!.width - 32
//            textView.height == 1500
            
        }
        
        
    }
    
    func reloadAfterInternetConnectionEstablished() {
        self.getPassportAndVisa()
    }
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.delegate = self
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        
        tv.isEditable = false
        tv.dataDetectorTypes = .link

        return tv
    }()
}
