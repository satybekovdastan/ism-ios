//
//  LibraryViewController.swift
//  ism
//
//  Created by DAS on 11/22/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class StudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Reloadable {
    
    static let storyboardId = "Student"
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Student]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.getStudent()
        self.title = "Student"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "student", for: indexPath) as! StudentTableViewCell

        cell.setupCell(item: self.items[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let number = URL(string: "tel://" + items[indexPath.item].number) else {return}
        UIApplication.shared.open(number)
    }
    
}
