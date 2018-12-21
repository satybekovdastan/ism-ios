//
//  Tickets.swift
//  ism
//
//  Created by DAS on 11/21/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class Tickets: Mappable {
    
    var id = 0
    var banner = ""
    var phone_number = ""
    var additional_phone_number1 = ""
    var additional_phone_number2 = ""
    var email = ""
    var url = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        banner <- map["banner"]
        phone_number <- map["phone_number"]
        additional_phone_number1 <- map["additional_phone_number1"]
        additional_phone_number2 <- map["additional_phone_number2"]
        email <- map["email"]
        url <- map["url"]
    }
    
}
