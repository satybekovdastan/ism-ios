//
//  ApplicantVC.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/21/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import Cartography

class ApplicantVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var confirmationCheck = false
    
    let letterCellId = "letterCellId"
    
    let tableViewData = ["Bona fide certificates", "Admission letter (Free structure)", "Additional"]
    
    var dictionary = [
        "group": "",
        "student_id": "",
        "semester": "",
        "admission_letter": false,
        "additional": "",
        "bona_fide": false,
        "campus": "",
        "date_of_birth": "",
        "citizenship": "",
        "name": "",
        "passport": ""
    ] as [String: Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 900)
        
        tableView.register(LetterCell.self, forCellReuseIdentifier: letterCellId)
        
        setupNavBar()
        navigationItem.title = "Applicant"
        
        view.addSubview(scrollView)
        
        constrain(scrollView) { scrollView in
            
            scrollView.top == scrollView.superview!.top
            scrollView.left == scrollView.superview!.left
            scrollView.right == scrollView.superview!.right
            scrollView.bottom == scrollView.superview!.bottom
            
        }
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(tableView)
        scrollView.addSubview(applicationLabel)
        scrollView.addSubview(studentId)
        scrollView.addSubview(name)
        scrollView.addSubview(dateOfBirth)
        scrollView.addSubview(passportNumber)
        scrollView.addSubview(citizenOf)
        scrollView.addSubview(campus)
        scrollView.addSubview(semester)
        
        constrain(titleLabel, tableView, applicationLabel, studentId, name, dateOfBirth, passportNumber, citizenOf, campus, semester) { titleLabel, tableView, applicationLabel, studentId, name, dateOfBirth, passportNumber, citizenOf, campus, semester in
            
            titleLabel.top == titleLabel.superview!.top + 25
            titleLabel.left == titleLabel.superview!.left + 20
            titleLabel.width == titleLabel.superview!.width - 40
            titleLabel.height == 36
            
            tableView.top == titleLabel.bottom + 27
            tableView.left == tableView.superview!.left
            tableView.width == tableView.superview!.width
            tableView.height == 96
            
            applicationLabel.top == tableView.bottom + 27
            applicationLabel.left == applicationLabel.superview!.left + 20
            applicationLabel.width == applicationLabel.superview!.width - 40
            applicationLabel.height == 18
            
            studentId.left == studentId.superview!.left + 20
            studentId.top == applicationLabel.bottom + 25
            studentId.width == studentId.superview!.width - 40
            studentId.height == 18
            
            name.left == name.superview!.left + 20
            name.top == studentId.bottom + 40
            name.width == name.superview!.width - 40
            name.height == 18
            
            dateOfBirth.left == dateOfBirth.superview!.left + 20
            dateOfBirth.top == name.bottom + 40
            dateOfBirth.width == dateOfBirth.superview!.width - 40
            dateOfBirth.height == 18
            
            passportNumber.left == passportNumber.superview!.left + 20
            passportNumber.top == dateOfBirth.bottom + 40
            passportNumber.width == passportNumber.superview!.width - 40
            passportNumber.height == 18
            
            citizenOf.left == citizenOf.superview!.left + 20
            citizenOf.top == passportNumber.bottom + 40
            citizenOf.width == citizenOf.superview!.width - 40
            citizenOf.height == 18
            
            campus.left == campus.superview!.left + 20
            campus.top == citizenOf.bottom + 40
            campus.width == campus.superview!.width - 40
            campus.height == 18
            
            semester.left == semester.superview!.left + 20
            semester.top == campus.bottom + 40
            semester.width == semester.superview!.width - 40
            semester.height == 18
            
        }
        
        scrollView.addSubview(group)
        scrollView.addSubview(additionalMessage)
        
        constrain(semester, group, additionalMessage){ semester, group, additionalMessage in
            
            group.left == group.superview!.left + 20
            group.top == semester.bottom + 40
            group.width == group.superview!.width - 40
            group.height == 18
            
            additionalMessage.left == additionalMessage.superview!.left + 20
            additionalMessage.top == group.bottom + 40
            additionalMessage.width == additionalMessage.superview!.width - 40
            additionalMessage.height == 18
            
        }
        
        containerViewForConfirmation.addSubview(confirmationLabel)
        containerViewForConfirmation.addSubview(checkImageView)
        
        constrain(confirmationLabel, checkImageView) { confirmationLabel, checkImageView in
            
            confirmationLabel.centerY == confirmationLabel.superview!.centerY
            confirmationLabel.left == confirmationLabel.superview!.left
            confirmationLabel.width == 185
            confirmationLabel.height == 15
            
            checkImageView.centerY == checkImageView.superview!.centerY
            checkImageView.right == checkImageView.superview!.right
            checkImageView.width == 18
            checkImageView.height == 18
            
        }
        
        view.addSubview(containerViewForConfirmation)
        view.addSubview(submitButton)
        
        constrain(additionalMessage, containerViewForConfirmation, submitButton) { additionalMessage, containerViewForConfirmation, submitButton in
            
            containerViewForConfirmation.centerX == containerViewForConfirmation.superview!.centerX
            containerViewForConfirmation.top == additionalMessage.bottom + 40
            containerViewForConfirmation.width == 223
            containerViewForConfirmation.height == 18
            
            submitButton.left == submitButton.superview!.left + 44
            submitButton.top == containerViewForConfirmation.bottom + 32
            submitButton.width == submitButton.superview!.width - 88
            submitButton.height == 36
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(letterChecked), name: .letterChecked, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(letterUnchecked), name: .letterUnchecked, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveDateTapped), name: .saveDate, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func letterChecked(_ notification: Notification) {
        
        let string = notification.object as! String
        if string == "Bona fide certificates" {
            dictionary["bona_fide"] = true
        } else if string == "Admission letter (Free structure)" {
            dictionary["admission_letter"] = true
        }
    }
    
    @objc func saveDateTapped(_ notification: Notification) {
        let object = notification.object as! DatePickerViewController
        dateOfBirth.text = object.formattedDate
        dictionary["date_of_birth"] = object.formattedDate
        
    }
    
    @objc func letterUnchecked(_ notification: Notification) {
        
        let string = notification.object as! String
        if string == "Bona fide certificates" {
            dictionary["bona_fide"] = false
        } else if string == "Admission letter (Free structure)" {
            dictionary["admission_letter"] = false
        }
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print("resized")
//        scrollView.resizeScrollViewContentHeight()
//    }
    
    lazy var scrollView: UIScrollView = {
        
        let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.delegate = self
        
        return sv
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 15)
        lbl.textAlignment = .left
        lbl.text = "Dear student,\nPlease choose the letter you need:"
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: UITableView.Style.plain)
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.allowsMultipleSelection = true
        tv.allowsMultipleSelectionDuringEditing = true

        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    let applicationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 15)
        lbl.textColor = .black
        lbl.text = "Application"
        
        return lbl
    }()
    
    lazy var studentId: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Student ID", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 15), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        addLineToView(view: tf)
        
        return tf
    }()
    
    lazy var name: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Name (According to passport)", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 15), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        addLineToView(view: tf)
        
        return tf
    }()
    
    lazy var dateOfBirth: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Date of birth", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 15), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        addLineToView(view: tf)
        
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dateOfBirthTapped)))
        
        return tf
    }()
    
    @objc func dateOfBirthTapped() {
        
        let vc = UIStoryboard(name: "DatePickerViewController", bundle: nil).instantiateInitialViewController() as! DatePickerViewController
        vc.isDateBirth = true
        present(vc, animated: true)
        
    }
    
    lazy var passportNumber: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Passport #", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 15), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        addLineToView(view: tf)
        
        return tf
    }()
    
    lazy var citizenOf: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Citizen of", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 15), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        addLineToView(view: tf)
        
        return tf
    }()
    
    lazy var campus: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Campus", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 15), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        addLineToView(view: tf)
        
        return tf
    }()
    
    lazy var semester: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Semester", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 15), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        addLineToView(view: tf)
        
        return tf
    }()
    
    lazy var group: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Group", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 15), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        addLineToView(view: tf)
        
        return tf
    }()
    
    lazy var additionalMessage: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Additional message", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoRegular, size: 15), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        addLineToView(view: tf)
        
        return tf
    }()
    
    func addLineToView(view : UIView) {
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        
        constrain(lineView, view) { lineView, view in
            
            lineView.top == view.bottom
            lineView.left == view.left
            lineView.right == view.right
            lineView.height == 1
            
        }
        
    }
    
    lazy var containerViewForConfirmation: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(confirmationContainerTapped)))
        return view
    }()
    
    @objc func confirmationContainerTapped() {
        if confirmationCheck == false {
            checkImageView.image = UIImage(named: "confirmationChecked")?.withRenderingMode(.alwaysOriginal)
            confirmationCheck = true
        } else if confirmationCheck == true {
            checkImageView.image = UIImage(named: "confirmationUnchecked")?.withRenderingMode(.alwaysOriginal)
            confirmationCheck = false
        }
    }
    
    let confirmationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.robotoRegular, size: 12)
        lbl.textAlignment = .center
        lbl.text = "I confirm my personal information"
        return lbl
    }()
    
    let checkImageView: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "confirmationUnchecked")?.withRenderingMode(.alwaysOriginal)
        iv.image = image
        
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    let submitButton: UIButton = {
        let bn = UIButton(type: .system)
        
        bn.backgroundColor = UIColor(red: 0, green: 0.78, blue: 0.33, alpha: 1)
        let attributedString = NSAttributedString(string: "SUBMIT", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.robotoMedium, size: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        bn.setAttributedTitle(attributedString, for: .normal)
        
        bn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        return bn
    }()
    
    @objc func submitTapped(_ sender: UIButton) {
        validateData()
    }
    
    func validateData() {
        if studentId.text!.isEmpty && name.text!.isEmpty && dateOfBirth.text!.isEmpty && passportNumber.text!.isEmpty && citizenOf.text!.isEmpty && campus.text!.isEmpty && semester.text!.isEmpty && group.text!.isEmpty {
            
            let alert = UIAlertController(title: "Error", message: "Fill in all required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            
        } else {
            
            if confirmationCheck == true {
                
                dictionary["group"] = group.text
                dictionary["student_id"] = studentId.text
                dictionary["semester"] = semester.text
                dictionary["additional"] = additionalMessage.text
                dictionary["campus"] = campus.text
                dictionary["date_of_birth"] = dateOfBirth.text
                dictionary["citizenship"] = citizenOf.text
                dictionary["name"] = name.text
                dictionary["passport"] = passportNumber.text
                
                ApiInteractor.shared.setLetter(parameters: dictionary) { (responseString) in
                    let alert = UIAlertController(title: "", message: responseString!, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true)
                }
                
            } else if confirmationCheck == false {
                let alert = UIAlertController(title: "Error", message: "Confirm you personal information", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alert, animated: true)
                
            }
            
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: letterCellId) as! LetterCell
        cell.letterLabel.text = tableViewData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
        }
    }
    
}

extension UIScrollView {
    
    func resizeScrollViewContentHeight() {
        var contentRect = CGRect.zero
        for view in self.subviews {
            contentRect = contentRect.union(view.frame)
        }
        self.contentSize.height = contentRect.size.height
    }
    
}
