//
//  IsmViewController.swift
//  ism
//
//  Created by DAS on 11/27/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class IsmViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let webURL = NSURL(string: "http://ism.edu.kg/")
        let request = URLRequest(url: webURL! as URL)
        self.webView.loadRequest(request)    }
    

  
}
