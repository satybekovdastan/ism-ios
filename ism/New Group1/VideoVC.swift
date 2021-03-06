//
//  LibraryViewController.swift
//  ism
//
//  Created by DAS on 11/22/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift

class VideoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, Reloadable {
    
    static let storyboardId = "Video"
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Video]()
    var videoURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.getVideos()
        self.setupNavBar()
    }
    
    func getVideos() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getVideo{ (response, errorString) in
            self.view.hideToastActivity()
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
        self.getVideos()
    }
    
    // MARK: - TableView Delegate and Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTVCell", for: indexPath) as! VideoTVCell
        
        cell.setupCell(item: self.items[indexPath.item])
        
        cell.share.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        videoURL = self.items[indexPath.item].youtube_video_id
        cell.share.isUserInteractionEnabled = true
        cell.share.addGestureRecognizer(tap)
        return cell
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let activityVC = UIActivityViewController(activityItems: ["https://www.youtube.com/watch?v=\(videoURL)"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
