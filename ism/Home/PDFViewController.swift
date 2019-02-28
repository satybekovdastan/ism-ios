//
//  PDFViewController.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/28/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import PDFKit
import Cartography

class PDFViewController: UIViewController {
    
    var pdfView = PDFView()
    var pdfURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(pdfView)
        view.addSubview(backButton)
        
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
        
        constrain(backButton) { backButton in
            
            backButton.left == backButton.superview!.left + 16
            backButton.top == backButton.superview!.safeAreaLayoutGuide.top + 16
            backButton.height == 25
            backButton.width == 16
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        pdfView.frame = view.frame
    }
    
    lazy var backButton: UIButton = {
        
        let bn = UIButton(type: .system)
        bn.setBackgroundImage(UIImage(named: "backButton"), for: .normal)
        bn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return bn
    }()
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
