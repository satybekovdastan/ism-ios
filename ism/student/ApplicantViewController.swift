//
//  ApplicantViewController.swift
//  ism
//
//  Created by DAS on 10/30/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import LTHRadioButton

class ApplicantViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var maleRadioButton: LTHRadioButton!
    
    @IBOutlet weak var femaleRadioButton: LTHRadioButton!
    
    @IBOutlet weak var dateOfBirth: PaddingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ISM"
        
        setupRadioButtonListeners()
        setupUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dateOfBirthTapped))
        dateOfBirth.isUserInteractionEnabled = true
        dateOfBirth.addGestureRecognizer(tap)
    }
    
    @objc func dateOfBirthTapped() {
        print("Hello")
    }
    
    func setupUI() {
        
        dateOfBirth.layer.borderColor = UIColor.lightGray.cgColor
        dateOfBirth.layer.borderWidth = 0.5
        dateOfBirth.layer.cornerRadius = 3
        
    }
    
    func setupRadioButtonListeners() {
        maleRadioButton.onSelect {
            self.maleRadioButton.select()
            self.femaleRadioButton.deselect()
        }
        
        maleRadioButton.onDeselect {
            self.maleRadioButton.deselect()
        }
        
        femaleRadioButton.onSelect {
            self.femaleRadioButton.select()
            self.maleRadioButton.deselect()
        }
        
        femaleRadioButton.onDeselect {
            self.femaleRadioButton.deselect()
            
        }
    }
    
    
    
    
    
//    private lazy var radioButton: LTHRadioButton = {
//        let r = LTHRadioButton()
//        view.addSubview(r)
//
//        r.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            r.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
//            r.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
//            r.heightAnchor.constraint(equalToConstant: r.frame.height),
//            r.widthAnchor.constraint(equalToConstant: r.frame.width)]
//        )
//
//        return r
//    }()


}

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 1.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
