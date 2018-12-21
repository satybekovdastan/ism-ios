//
//  VideoTableViewCell.swift
//  ism
//
//  Created by DAS on 12/18/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import youtube_ios_player_helper // You're missing this line

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoView: YTPlayerView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var share: UIImageView!
    @IBOutlet weak var desc: UILabel!
    var isAcctive:Bool = false

    func setupCell(item:Video) {
        self.selectionStyle = .none
        print("VIDEO \(item.youtube_video_id)")
        self.title.text = item.title
        self.desc.text = item.description

        if isAcctive == false{
            self.videoView?.load(withVideoId: item.youtube_video_id)
            isAcctive = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.title.text = nil
        self.desc.text = nil
        self.videoView = nil
    }
}
