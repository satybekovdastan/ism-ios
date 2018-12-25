//
//  Schedule.swift
//  ism
//
//  Created by Atay Sultangaziev on 12/25/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class Schedule: Mappable {
    
    var class_date = ""
    var week_day = ""
    var semester = 0
    var course = 0
    var groups = [Group]()
    var subjects = [Subject]()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        class_date <- map["class_date"]
        week_day <- map["week_day"]
        semester <- map["semester"]
        course <- map["course"]
        groups <- map["groups"]
        subjects <- map["subjects"]
    }
    
}
