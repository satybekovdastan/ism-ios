//
//  TicketViewController.swift
//  ism
//
//  Created by DAS on 11/21/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class TaxiVC: UIViewController, UITableViewDelegate, UITableViewDataSource, Reloadable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Tickets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.getTickets()
        self.setupNavBar()
    }
    
    func getTickets() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getTaxi{ (response, errorString) in
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
        self.getTickets()
    }
    
    // MARK: - TableView Delegate and Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaxi", for: indexPath) as! TaxiTVCell
        
        cell.setupCell(item: self.items[indexPath.item].additional_phone_number1, image: items[indexPath.row].banner, phone2: items[indexPath.row].additional_phone_number2, email: items[indexPath.row].email, url: items[indexPath.row].url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
