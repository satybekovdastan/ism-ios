//
//  DatePickerViewController.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/23/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var isDateBirth: Bool?
    var isDateOfIssue: Bool?
    var isDateOfExpiery: Bool?
    var isYearOfCompletion: Bool?
    var isLetterDateBirth: Bool?
    
    var formattedDate: String {
        get {
            let formatter = DateFormatter()
            if isYearOfCompletion != nil {
                formatter.dateFormat = "YYYY"
            } else {
                formatter.dateFormat = "YYYY-MM-dd"
            }
            return formatter.string(from: datePicker.date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavBar()
        
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: .saveDate, object: self)
        dismiss(animated: true)
    }
    
    
}
