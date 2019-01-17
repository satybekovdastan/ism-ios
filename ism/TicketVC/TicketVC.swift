//
//  TicketViewController.swift
//  ism
//
//  Created by DAS on 11/21/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class TicketVC: UIViewController, UITableViewDelegate, UITableViewDataSource, Reloadable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Tickets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        tableView.separatorStyle = .none
        self.getCategories()
        self.setupNavBar()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func getCategories() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getFavorites{ (response, errorString) in
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
        self.getCategories()
    }
    
    // MARK: - TableView Delegate and Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTicket", for: indexPath) as! TicketTVCell
        
        cell.item = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }

}
