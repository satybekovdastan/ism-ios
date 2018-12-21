//
//  Student.swift
//  ism
//
//  Created by DAS on 11/23/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class Student: Mappable {
    
    var id = 0
    var name = ""
    var position = ""
    var number = ""

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        position <- map["position"]
        number <- map["number"]
    }
    
}
