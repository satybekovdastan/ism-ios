//
//  ScheduleViewController.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/24/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class ScheduleVC: UIViewController, Reloadable {
    
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var semesterLabel: UILabel!
    
    func reloadAfterInternetConnectionEstablished() {
        getGroups()
        getSemesters()
    }
    
    var groupItems = [Group]()
    var semesterItems = [Semester]()
    
    var selectedGroup: Group?
    var selectedSemester: Semester?
    
    var groupActionSheet: UIAlertController?
    var semesterActionSheet: UIAlertController?
    
    var listViewStoryboard: UIStoryboard?
    var vc: ScheduleCV?
    
    @IBAction func okButtonTapped(_ sender: Any) {
        if selectedGroup == nil || selectedSemester == nil {
            let alert = UIAlertController(title: "Error", message: "Choose both groups and semester options", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            getSchedules()
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.initializeActionSheets()
        self.initializeViewController()
        self.setGestureRecognizers()
        self.getGroups()
        self.getSemesters()
        self.setupNavBar()
        navigationItem.title = "ISM"
        
    }
    
    func initializeViewController() {
        vc = UIStoryboard(name: "ScheduleCV", bundle: nil).instantiateInitialViewController()! as? ScheduleCV
    }
    
    func initializeActionSheets() {
        groupActionSheet = UIAlertController(title: "Groups", message: "Choose group", preferredStyle: .actionSheet)
        semesterActionSheet = UIAlertController(title: "Semesters", message: "Choose semester", preferredStyle: .actionSheet)
    }
    
    func setGestureRecognizers() {
        let groupTap = UITapGestureRecognizer(target: self, action: #selector(ScheduleVC.groupLabelTapped))
        groupLabel.isUserInteractionEnabled = true
        groupLabel.addGestureRecognizer(groupTap)

        let semesterTap = UITapGestureRecognizer(target: self, action: #selector(ScheduleVC.semesterLabelTapped))
        semesterLabel.isUserInteractionEnabled = true
        semesterLabel.addGestureRecognizer(semesterTap)
    }
    
    @objc func groupLabelTapped(sender: UITapGestureRecognizer? = nil) {
        present(groupActionSheet!, animated: true)
    }
    
    @objc func semesterLabelTapped(sender: UITapGestureRecognizer? = nil) {
        present(semesterActionSheet!, animated: true)
    }
    
    func getGroups() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getGroup{ (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                print("COUNT \(String(describing: response?.count))")
                if let data = response {
                    
                    self.groupItems = data
                    for item in self.groupItems {
                        self.groupActionSheet!.addAction(UIAlertAction(title: "\(item.name)", style: .default, handler: { (action) in
                            self.groupLabel.text = "\(item.name)"
                            self.selectedGroup = item
                            self.vc?.selectedGroup = self.selectedGroup
                        }))
                    }
                    self.groupActionSheet!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        }
    }
    
    func getSemesters() {
        
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getSemester( success: { (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                print("COUNT \(String(describing: response?.count))")
                if let data = response {
                    self.semesterItems = data
                    for item in self.semesterItems {
                        
                        self.semesterActionSheet!.addAction(UIAlertAction(title: "\(item.semester)", style: .default, handler: { (action) in
                            self.semesterLabel.text = "\(item.semester)"
                            self.selectedSemester = item
                            self.vc?.selectedSemester = self.selectedSemester
                        }))
                    }
                    self.semesterActionSheet!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        })
    }
    
    func getSchedules() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getSchedule ( groupId: selectedGroup!.id, semesterId: selectedSemester!.id, success: { (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                print("COUNT \(String(describing: response?.count))")
                if let data = response {
                    
                    self.vc?.scheduleItems = data
                    
                    self.navigationController?.pushViewController(self.vc!, animated: true)
                    
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        })
    }
}
