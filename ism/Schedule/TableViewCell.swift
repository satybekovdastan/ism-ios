//
//  TableViewCell.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/24/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var schedule: [Schedule]?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
