//
//  NewCampus.swift
//  ism
//
//  Created by Atay Sultangaziev on 1/31/19.
//  Copyright © 2019 sunrise. All rights reserved.

import UIKit
import ObjectMapper

class NewCampus: Mappable {
    
    var id = 0
    var name = ""
    var image = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var address = ""
    var phone_number = ""
    var additional_phone_number1 = ""
    var additional_phone_number2 = ""
    var email = ""
    var description = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        address <- map["address"]
        phone_number <- map["phone_number"]
        additional_phone_number1 <- map["additional_phone_number1"]
        additional_phone_number2 <- map["additional_phone_number2"]
        email <- map["email"]
        description <- map["description"]
        
    }
    
}
