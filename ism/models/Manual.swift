//
//  Manual.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/28/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import ObjectMapper

struct Manual: Mappable {
    
    var id = 0
    var manual = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        manual <- map["manual"]
        
    }
}
