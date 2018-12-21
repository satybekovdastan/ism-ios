//
//  Library.swift
//  ism
//
//  Created by DAS on 11/22/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class Library: Mappable {

    var id = 0
    var title = ""
    var author = ""
    var cover = ""
    var book = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        author <- map["author"]
        cover <- map["cover"]
        book <- map["book"]
    }
    
}
