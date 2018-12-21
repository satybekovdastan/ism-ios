//
//  VideoViewController.swift
//  ism
//
//  Created by DAS on 11/2/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class VideoViewControllerTest: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellVideo2", for: indexPath)
        as! VideoTableViewCellTest
        
        let videoURL = NSURL(string: "https://www.youtube.com/watch?v=4BCxqrhsjOw")
        
        let request = URLRequest(url: videoURL! as URL)
        cell.webView.loadRequest(request)
        
        return cell
    }
}
