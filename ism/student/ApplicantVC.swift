//
//  ApplicantViewController.swift
//  ism
//
//  Created by DAS on 10/30/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class ApplicantVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var citizenshipTextField: UITextField!
    @IBOutlet weak var maritalStatusLabel: UILabel!
    @IBOutlet weak var passportNumberTextField: UITextField!
    @IBOutlet weak var dateOfIssueLabel: UILabel!
    @IBOutlet weak var permanentAdressTextField: UITextField!
    @IBOutlet weak var dateOfExpieryLabel: UILabel!
    @IBOutlet weak var parentNameTextField: UITextField!
    @IBOutlet weak var motherTextField: UITextField!
    @IBOutlet weak var fatherTextField: UITextField!
    @IBOutlet weak var addressOfParentsTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var statementOfSupportTextField: UITextField!
    @IBOutlet weak var schoolInformationTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var schoolAddressTextField: UITextField!
    @IBOutlet weak var yearOfCompletionTextField: UITextField!
    @IBOutlet weak var academicRecordTextField: UITextField!
    @IBOutlet weak var gradeAverageTextField: UITextField!
    @IBOutlet weak var uploadPhotoView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
    }
    
    var observer: NSObjectProtocol?
    
    func setDelegates() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        citizenshipTextField.delegate = self
        passportNumberTextField.delegate = self
        permanentAdressTextField.delegate = self
        parentNameTextField.delegate = self
        motherTextField.delegate = self
        fatherTextField.delegate = self
        addressOfParentsTextField.delegate = self
        contactNumberTextField.delegate = self
        statementOfSupportTextField.delegate = self
        schoolInformationTextField.delegate = self
        schoolNameTextField.delegate = self
        schoolAddressTextField.delegate = self
        yearOfCompletionTextField.delegate = self
        academicRecordTextField.delegate = self
        gradeAverageTextField.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        setDelegates()
        
        setNotifications()
        
//        setupLabelGestureRecognizers()
        
        
//
//        observer = NotificationCenter.default.addObserver(forName: .saveDate, object: nil, queue: nil) { (notification) in
//            let vc = notification.object as! DatePickerViewController
//            print("hello")
//            if vc.isDateBirth == true {
//                self.dateOfBirth.text = vc.formattedDate
//            }
        
//        }
        
//        let photoTap = UITapGestureRecognizer(target: self, action: #selector(downloadPhotoTapped))
//        downloadPhoto.addGestureRecognizer(photoTap)
    }
    
//    func setupLabelGestureRecognizers() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dateOfBirthLabelTapped))
//    dateOfBirthLabel.addGestureRecognizer(tap)
//    }
    
    func setNotifications() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ApplicantVC.keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ApplicantVC.keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)

        print("Before \(scrollView.contentInset.bottom)")

        scrollView.contentInset.bottom +=  adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight

//        viewDidLayoutSubviews()
//        self.scrollView.layoutIfNeeded()
        
//        print("After \(scrollView.contentInset.bottom)")
        
//        if (!show) {
//            scrollView.setContentOffset(CGPoint(x: 0, y: adjustmentHeight), animated: true)
//
//        }
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
        
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
//
//        var contentInset:UIEdgeInsets = self.scrollView.contentInset
//        contentInset.bottom = keyboardFrame.size.height
//        scrollView.contentInset = contentInset
        
//        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
//            return
//        }
//        let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: nil)
//        scrollView.contentOffset = CGPoint(x:0, y:keyboardFrame.size.height)
        
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        print("Im hided")
        adjustInsetForKeyboardShow(false, notification: notification)
        
//        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//        scrollView.contentInset = contentInset
        
//        scrollView.contentOffset = .zero
    }
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        
//        nameTextField.endEditing(true)
//        surnameTextField.endEditing(true)
//        citizenshipTextField.endEditing(true)
//        passportNumberTextField.endEditing(true)
//        permanentAdressTextField.endEditing(true)
//        parentNameTextField.endEditing(true)
//        motherTextField.endEditing(true)
//        fatherTextField.endEditing(true)
//        addressOfParentsTextField.endEditing(true)
//        contactNumberTextField.endEditing(true)
//        statementOfSupportTextField.endEditing(true)
//        schoolInformationTextField.endEditing(true)
//        schoolNameTextField.endEditing(true)
//        schoolAddressTextField.endEditing(true)
//        yearOfCompletionTextField.endEditing(true)
//        academicRecordTextField.endEditing(true)
//        gradeAverageTextField.endEditing(true)
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        activeTextField = textField
//        lastOffset = self.scrollView.contentOffset
//        return true
//    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        activeTextField!.resignFirstResponder()
//        activeTextField = nil
//
//        return true
//    }
//
//    func addKeyboardObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            keyboardHeight = keyboardSize.height
//            // so increase contentView's height by keyboard height
//            UIView.animate(withDuration: 0.3, animations: {
//                self.constraintContentHeight.constant += self.keyboardHeight
//            })
//            // move if keyboard hide input field
//            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
//            let collapseSpace = keyboardHeight - distanceToBottom
//            if collapseSpace < 0 {
//                // no collapse
//                return
//            }
//        }
//    }
    
//    @objc func keyboardWillHide(notification: NSNotification) {
//
//    }
    
//    @objc func downloadPhotoTapped() {
//        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
//        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
//
//        }))
//        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
//
//        }))
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(actionSheet, animated: true)
//    }
    
//    @objc func dateOfBirthLabelTapped() {
//        let storyboard = UIStoryboard(name: "DatePickerViewController", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController() as! DatePickerViewController
//        vc.isDateBirth = true
//        self.present(vc, animated: true)
//    }
    
    func setupRadioButtonListeners() {
//        maleRadioButton.onSelect {
//            self.maleRadioButton.select()
//            self.femaleRadioButton.deselect()
//        }
//
//        maleRadioButton.onDeselect {
//            self.maleRadioButton.deselect()
//        }
//
//        femaleRadioButton.onSelect {
//            self.femaleRadioButton.select()
//            self.maleRadioButton.deselect()
//        }
//
//        femaleRadioButton.onDeselect {
//            self.femaleRadioButton.deselect()
//
//        }
    }
    


}
