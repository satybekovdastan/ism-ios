//
//  CustomCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/24/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class ScheduleCVCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var class_date: UILabel!
    @IBOutlet weak var week_day: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentSchedule: Schedule? {
        didSet {
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentSchedule!.subjects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTVCell", for: indexPath) as! ScheduleTVCell
        cell.class_time.text = currentSchedule?.subjects[indexPath.row].class_time
        cell.subject.text = currentSchedule?.subjects[indexPath.row].subject
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    override func awakeFromNib() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        
        
    }
    

    
    
    
}
