//
//  Event.swift
//  ism
//
//  Created by DAS on 12/13/18.
//  Copyright © 2018 sunrise. All rights reserved.
//


import UIKit
import ObjectMapper

class Event: Mappable {
    
    var id = 0
    var title = ""
    var slug = ""
    var date = ""
    var description = ""
    var image = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        slug <- map["slug"]
        date <- map["date"]
        description <- map["description"]
        image <- map["image"]
    }
    
}

