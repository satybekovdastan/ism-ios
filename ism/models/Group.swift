//
//  Group.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/25/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class Group: Mappable {
    
    var id = 0
    var name = 0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
