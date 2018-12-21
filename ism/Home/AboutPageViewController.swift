//
//  AboutPageViewController.swift
//  ism
//
//  Created by DAS on 10/26/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import youtube_ios_player_helper // You're missing this line
import Toast_Swift

class AboutPageViewController: UIViewController, Reloadable {

    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var youtubeView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAbout()
    }
    
    func getAbout() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getAbout{ (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                if let data = response {
                    var items = [About]()
                    items = data;
                    self.youtubeView.load(withVideoId: items[0].youtube_video_id)
                    self.textViewDescription.text = items[0].text.htmlToString
                
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        }
    }
    
    func reloadAfterInternetConnectionEstablished() {
        self.getAbout()
    }

}
