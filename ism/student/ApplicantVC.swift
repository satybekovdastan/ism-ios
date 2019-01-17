//
//  ApplicantViewController.swift
//  ism
//
//  Created by DAS on 10/30/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class ApplicantVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var activeTextField = UITextField()

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
    @IBOutlet weak var yearOfCompletionLabel: UILabel!
    @IBOutlet weak var academicRecordTextField: UITextField!
    @IBOutlet weak var gradeAverageTextField: UITextField!
    @IBOutlet weak var uploadPhotoView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    func validateData() {
        
        if nameTextField.text!.isEmpty || surnameTextField.text!.isEmpty || isGenderChosen == nil || isDateOfBirthChosen == nil || citizenshipTextField.text!.isEmpty || isMaritalStatusChosen == nil || isDateOfIssueChosen == nil || isDateOfExpieryChosen == nil || isCompletionYearChosen == nil || gradeAverageTextField.text!.isEmpty || imageView.image == nil {
            
            let alert = UIAlertController(title: "Error", message: "Please fill out all required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            
        } else {
            var parameters = [
                "birthday": "\(dateOfBirthLabel.text)",
                "fin_support_statement": "\(statementOfSupportTextField.text)",
                "academic_record": "\(academicRecordTextField.text)",
                "father": "\(fatherTextField.text)",
//                "image":
                "expiry_date": "\(dateOfExpieryLabel.text)",
                "citizenship": "\(citizenshipTextField.text)",
                "surname": "\(surnameTextField.text)",
                "contact_number": "\(contactNumberTextField.text)",
                "gpa": "\(gradeAverageTextField.text)",
                "name": "\(nameTextField.text)",
                "mother": "\(motherTextField.text)",
                "gender": "\(genderLabel.text)",
                "issue_date": "\(dateOfIssueLabel.text)",
                "school_information": "\(schoolInformationTextField.text)",
                "school_name": "\(schoolNameTextField.text)",
                "marital_status": "\(maritalStatusLabel.text)",
                "passport_number": "\(passportNumberTextField.text)",
                "completion_year": "\(yearOfCompletionLabel.text)",
                "school_address": "\(schoolAddressTextField.text)",
                "address": "\(addressOfParentsTextField.text)"
        
            ]
            self.view.makeToastActivity(.center)
            ApiInteractor.shared.setApplicant(parameters: parameters, selectedImage: imageView.image!) { (success) in
                self.view.hideToastActivity()
                print("\(success)")
            }
            
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        validateData()
    }
    
    var isDateOfBirthChosen: Bool? = nil
    var isGenderChosen: Bool? = nil
    var isMaritalStatusChosen: Bool? = nil
    var isDateOfIssueChosen: Bool? = nil
    var isDateOfExpieryChosen: Bool? = nil
    var isCompletionYearChosen: Bool? = nil
    
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
        academicRecordTextField.delegate = self
        gradeAverageTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        setDelegates()
        
        setNotifications()

    }
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(saveDate), name: .saveDate, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @objc func saveDate(_ notification: NSNotification) {
        
        let vc = notification.object as! DatePickerViewController
        
        if vc.isDateBirth != nil {
            dateOfBirthLabel.text = vc.formattedDate
            isDateOfBirthChosen = true
        } else if vc.isDateOfIssue != nil {
            dateOfIssueLabel.text = vc.formattedDate
            isDateOfIssueChosen = true
        } else if vc.isDateOfExpiery != nil {
            dateOfExpieryLabel.text = vc.formattedDate
            isDateOfExpieryChosen = true
        } else if vc.isYearOfCompletion != nil {
            yearOfCompletionLabel.text = vc.formattedDate
            isCompletionYearChosen = true
        }
        
    }
    
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        
        scrollView.contentInset.bottom +=  adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        activeTextField.endEditing(true)
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
   
    @IBAction func genderLabelTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Gender", message: "Please, choose your gender", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Male", style: .default, handler: { (action) in
            self.genderLabel.text = "Male"
            self.isGenderChosen = true
        }))
        alert.addAction(UIAlertAction(title: "Female", style: .default, handler: { (action) in
            self.genderLabel.text = "Female"
            self.isGenderChosen = true
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func dateBirthLabelTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "DatePickerViewController", bundle: nil).instantiateInitialViewController() as! DatePickerViewController
        vc.isDateBirth = true
        let navC = UINavigationController(rootViewController: vc)
        present(navC, animated: true)
    }
    
    @IBAction func maritalStatusLabelTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Marital status", message: "Please, choose your marital status", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Single", style: .default, handler: { (action) in
            self.maritalStatusLabel.text = "Single"
            self.isMaritalStatusChosen = true
        }))
        alert.addAction(UIAlertAction(title: "Married", style: .default, handler: { (action) in
            self.maritalStatusLabel.text = "Married"
            self.isMaritalStatusChosen = true
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func dateOfIssueLabelTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "DatePickerViewController", bundle: nil).instantiateInitialViewController() as! DatePickerViewController
        vc.isDateOfIssue = true
        let navC = UINavigationController(rootViewController: vc)
        present(navC, animated: true)
    }
    
    @IBAction func dateOfExpieryLabelTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "DatePickerViewController", bundle: nil).instantiateInitialViewController() as! DatePickerViewController
        vc.isDateOfExpiery = true
        let navC = UINavigationController(rootViewController: vc)
        present(navC, animated: true)
    }
    
    @IBAction func downloadPhotoTapped(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            } else {
                let alert = UIAlertController(title: "Camera", message: "Camera is not available", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    
    @IBAction func yearOfCompletionLabel(_ sender: Any) {
        let vc = UIStoryboard(name: "DatePickerViewController", bundle: nil).instantiateInitialViewController() as! DatePickerViewController
        vc.isYearOfCompletion = true
        let navC = UINavigationController(rootViewController: vc)
        present(navC, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    


}
