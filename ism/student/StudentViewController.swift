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
    
    static let storyboardId = "Library"
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Library]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.getLibrary()
        self.title = "Library"
    }
    
    func getLibrary() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getLibrary{ (response, errorString) in
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
        self.getLibrary()
    }
    
    // MARK: - TableView Delegate and Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "library", for: indexPath) as! LibraryTableViewCell
        
        cell.setupCell(name: self.items[indexPath.item].title, author: items[indexPath.row].author, image: items[indexPath.row].cover)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // swiftlint:disable force_cast
        //        let destinationVC = UIStoryboard.init(name: TicketViewController.storyboardId, bundle: nil).instantiateInitialViewController() as! TreeViewFilterViewController
        //        // swiftlint:enable force_cast
        //
        //        destinationVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //        destinationVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        //        destinationVC.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        //        destinationVC.tabBarController?.tabBar.isHidden = true
        //
        //        destinationVC.categorySlug = self.items[indexPath.item].slug
        //
        //        self.navigationController?.popViewController(animated: false)
        //        self.present(destinationVC, animated: true, completion: nil)
    }
    
}
