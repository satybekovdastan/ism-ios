//
//  Council.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/26/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import ObjectMapper

struct Council: Mappable {
    
    var id = 0
    var image = ""
    var text = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        image <- map["image"]
        text <- map["text"]
    }
}
