//
//  LibraryViewController.swift
//  ism
//
//  Created by DAS on 11/22/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class ContactsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, Reloadable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.setupNavBar()
        getStudent()
    }
    
    func getStudent() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getStudents{ (response, errorString) in
            self.view.hideToastActivity()
            print("Response \(String(describing: response?.count))")
            if errorString == nil {
                if let data = response {
                    self.items = data
                    self.tableView.reloadData()
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        }
    }
    
    func reloadAfterInternetConnectionEstablished() {
        self.getStudent()
    }
    
    // MARK: - TableView Delegate and Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "student", for: indexPath) as! ContactsTVCell

        cell.setupCell(item: self.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let number = URL(string: "tel://" + items[indexPath.row].number) else {return}
        UIApplication.shared.open(number)
    }
    
    
}
