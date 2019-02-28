//
//  AboutUs.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/22/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import Foundation
import ObjectMapper

struct AboutUs: Mappable {
    
    var id = 0
    var youtube_url = ""
    var text = ""
    var instagram = ""
    var facebook = ""
    var website = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        youtube_url <- map["youtube_url"]
        text <- map["text"]
        instagram <- map["instagram"]
        facebook <- map["facebook"]
        website <- map["website"]
        
    }
}
