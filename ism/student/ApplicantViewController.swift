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
    @IBOutlet weak var downloadPhoto: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        scrollView.contentSize = CGSize(width: 375, height: 1500)
//        scrollView.frame = CGRect(x: 0, y: 0, width: 375, height: 500)
        scrollView.contentSize = contentView.frame.size
        self.navigationItem.title = "ISM"
        
        setupRadioButtonListeners()
        setupUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dateOfBirthTapped))
        dateOfBirth.isUserInteractionEnabled = true
        dateOfBirth.addGestureRecognizer(tap)
        
        observer = NotificationCenter.default.addObserver(forName: .saveDate, object: nil, queue: nil) { (notification) in
            let vc = notification.object as! DatePickerViewController
            print("hello")
            if vc.isDateBirth == true {
                self.dateOfBirth.text = vc.formattedDate
            }
            
        }
        
        let photoTap = UITapGestureRecognizer(target: self, action: #selector(downloadPhotoTapped))
        downloadPhoto.addGestureRecognizer(photoTap)
    }
    
    @objc func downloadPhotoTapped() {
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    
   
    @objc func dateOfBirthTapped() {
        let storyboard = UIStoryboard(name: "DatePickerViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! DatePickerViewController
        vc.isDateBirth = true
        self.present(vc, animated: true)
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
