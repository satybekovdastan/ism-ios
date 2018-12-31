//
//  ViewController.swift
//  ism
//
//  Created by DAS on 12/13/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class EventsTVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var textDesc: UITextView!
    @IBOutlet weak var labelDesc: UILabel!
    
    var event:Event!

    func customInit(item: Event) {
        self.event = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = event.title
        self.dateLabel.text = event.date
        self.labelDesc.text = event.description.htmlToString
        self.imageView.sd_setImage(with: URL.init(string: event.image), completed: nil)
    }
    
    

}
