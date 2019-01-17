//
//  LetterVC.swift
//  ism
//
//  Created by Atay Sultangaziev on 1/10/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class LetterVC: UIViewController, UITextFieldDelegate {
    
    var activeTextField: UITextField!
    
    @IBOutlet weak var chooseLabel: UILabel!
    var isLetterChosen: Bool? = nil
    var isMarkSheet: Bool? = false
    var isBonaFide: Bool? = false
    var isAdmissionLetter: Bool? = false
    
    @IBOutlet weak var confirmLabel: UILabel!
    var isInfoConfirmed: Bool? = nil
    
    @IBOutlet weak var birthDateLabel: UILabel!
    var isBirthDateChoosen: Bool? = nil
    
    @IBOutlet weak var nameTextField: UITextField!
    var isNameChosen: Bool? = nil
    
    @IBOutlet weak var passportTextField: UITextField!
    var isPassportChosen: Bool? = nil
    
    @IBOutlet weak var citizenTextField: UITextField!
    var isCitizenChosen: Bool? = nil
    
    @IBOutlet weak var campusTextField: UITextField!
    var isCampusChosen: Bool? = nil
    
    @IBOutlet weak var semesterTextField: UITextField!
    var isSemesterChosen: Bool? = nil
    
    @IBOutlet weak var groupTextField: UITextField!
    var isGroupChosen: Bool? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        addGestureRecognizers()
        
        setupConfirmLabel()
        
        addObservers()
        
        setDelegates()
    }
    
    @objc func chooseLabelTapped() {
        let actionSheet = UIAlertController(title: "Letter", message: "Choose letter please", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Bona fide certificates", style: .default, handler: { (action) in
            self.chooseLabel.text = "Bona fide certificates"
            self.isLetterChosen = true
            self.isBonaFide = true
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Admission letter (Free structure)", style: .default, handler: { (action) in
            self.chooseLabel.text = "Admission letter (Free structure)"
            self.isLetterChosen = true
            self.isAdmissionLetter = true
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Mark sheet", style: .default, handler: { (action) in
            self.chooseLabel.text = "Mark sheet"
            self.isLetterChosen = true
            self.isMarkSheet = true
        }))
        
        present(actionSheet, animated: true)
    }
    
    func addGestureRecognizers() {
        let chooseTap = UITapGestureRecognizer(target: self, action: #selector(chooseLabelTapped))
        chooseLabel.addGestureRecognizer(chooseTap)
        
        let confirmTap = UITapGestureRecognizer(target: self, action: #selector(confirmLabelTapped))
        confirmLabel.addGestureRecognizer(confirmTap)
        
        let birthDateTap = UITapGestureRecognizer(target: self, action: #selector(birthDateTapped))
        birthDateLabel.addGestureRecognizer(birthDateTap)
    }
    
    @objc func confirmLabelTapped() {
        let actionSheet = UIAlertController(title: "Confirm", message: "Confirm your information please", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Yes, I confirm my information", style: .default, handler: { (action) in
            if self.isInfoConfirmed == nil {
                let attrStr = NSMutableAttributedString(string: " ✅", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)])
                
                let boldString = NSMutableAttributedString(string: "Notes*: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
                let normalString = NSMutableAttributedString(string: "I confirm my personal inform", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
                
                boldString.append(normalString)
                boldString.append(attrStr)
                
                self.confirmLabel.attributedText = boldString
            }
            self.isInfoConfirmed = true
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    func setupConfirmLabel() {
        let boldString = NSMutableAttributedString(string: "Notes*: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        let normalString = NSMutableAttributedString(string: "I confirm my personal inform", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        boldString.append(normalString)
        
        confirmLabel.attributedText = boldString
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(birthDateChosen), name: .saveDate, object: nil)
    }
    
    @objc func birthDateTapped() {
        let datePickerVC = UIStoryboard(name: "DatePickerViewController", bundle: nil).instantiateInitialViewController() as! DatePickerViewController
        datePickerVC.isLetterDateBirth = true
        let navC = UINavigationController(rootViewController: datePickerVC)
        present(navC, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func birthDateChosen(notification: NSNotification) {
        let vc = notification.object as! DatePickerViewController
        birthDateLabel.text = vc.formattedDate
        isBirthDateChoosen = true
    }
    
    func validateData() {
        if isLetterChosen == nil || isInfoConfirmed == nil || isBirthDateChoosen == nil || nameTextField.text!.isEmpty || passportTextField.text!.isEmpty || citizenTextField.text!.isEmpty || campusTextField.text!.isEmpty || semesterTextField.text!.isEmpty || groupTextField.text!.isEmpty {
            
            let alert = UIAlertController(title: "Error", message: "Please fill out all required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            
        } else {
            var parameters: [String: Any] = [
                "semester": 1,
                "mark_sheet": isMarkSheet,
                "campus": "\(campusTextField.text)",
                "admission_letter": isAdmissionLetter,
                "date_of_birth": "\(birthDateLabel.text)",
                "bona_fide": isBonaFide,
                "passport": "\(passportTextField.text)",
                "name": "\(nameTextField.text)",
                "group": 1,
                "citizenship": "\(citizenTextField.text)"
            ]
            
            self.view.makeToastActivity(.center)
            ApiInteractor.shared.setLetter(parameters: parameters) { (success) in
                self.view.hideToastActivity()
                print(success)
            }
            
            
            
            
        }
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        activeTextField.font = UIFont.systemFont(ofSize: 14)
        activeTextField.textColor = UIColor.lightGray
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeTextField.resignFirstResponder()
        
        return true
    }
    
    func setDelegates() {
        nameTextField.delegate = self
        passportTextField.delegate = self
        citizenTextField.delegate = self
        campusTextField.delegate = self
        campusTextField.delegate = self
        semesterTextField.delegate = self
        groupTextField.delegate = self
    }
    
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        validateData()
    }
    
    
    
    
}
