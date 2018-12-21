//
//  ViewController.swift
//  ism
//
//  Created by DAS on 12/13/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class About: Mappable {

    var id = 0
    var youtube_video_id = ""
    var text = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        youtube_video_id <- map["youtube_video_id"]
        text <- map["text"]
    }
    

}
