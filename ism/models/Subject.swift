//
//  Subject.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/25/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class Subject: Mappable {
    
    var subject = ""
    var class_time = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        subject <- map["subject"]
        class_time <- map["class_time"]
    }
        
}
