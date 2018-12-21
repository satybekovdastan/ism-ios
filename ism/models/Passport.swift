//
//  Student.swift
//  ism
//
//  Created by DAS on 11/23/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class Passport: Mappable {
    
    var id = 0
    var passport_and_visa_procedure = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        passport_and_visa_procedure <- map["passport_and_visa_procedure"]
        
    }
    
}
