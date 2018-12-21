//
//  VideoTableViewCell.swift
//  ism
//
//  Created by DAS on 11/2/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class VideoTableViewCellTest: UITableViewCell {

    @IBOutlet weak var webView: UIWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
