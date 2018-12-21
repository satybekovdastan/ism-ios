//
//  Student.swift
//  ism
//
//  Created by DAS on 11/23/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class Video: Mappable {
    
    var id = 0
    var youtube_video_id = ""
    var title = ""
    var description = ""

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        youtube_video_id <- map["youtube_video_id"]
        title <- map["title"]
        description <- map["description"]

    }
    
}
