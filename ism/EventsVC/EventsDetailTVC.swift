//
//  DetailTableViewController.swift
//  ism
//
//  Created by DAS on 12/18/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class EventsDetailTVC: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    
    var event: Event? {
        didSet {
            self.tableView.tableFooterView = UIView(frame: .zero)
            self.labelTitle.text = event!.title
            self.dateLabel.text = event!.date
            self.labelDesc.text = event!.description.htmlToString
            self.imageView.sd_setImage(with: URL.init(string: event!.image), completed: nil)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        self.setupNavBar()

    }

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 2
//    }
//


}
