//
//  ViewController.swift
//  ism
//
//  Created by DAS on 12/13/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class Contact: Mappable {
    
    var id = 0
    var latitude = 0.0
    var longitude = 0.0
    var address = ""
    var phone_number = ""
    var additional_phone_number1 = ""
    var additional_phone_number2 = ""
    var email = ""

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        address <- map["address"]
        phone_number <- map["phone_number"]
        additional_phone_number1 <- map["additional_phone_number1"]
        additional_phone_number2 <- map["additional_phone_number2"]
        email <- map["email"]
    }
    
    
}
