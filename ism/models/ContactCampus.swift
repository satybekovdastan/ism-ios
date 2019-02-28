//
//  ContactCampus.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/20/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

struct ContactCampus: Mappable {
    
    var id = 0
    var name = ""
    var image = ""
    var address = ""
    var roles = [Staff]()
    var taxis = [NewTaxi]()
    var air_tickets = [NewAir]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        address <- map["address"]
        roles <- map["roles"]
        taxis <- map["taxis"]
        air_tickets <- map["air_tickets"]
    }
}

struct Staff: Mappable {
    
    var title = ""
    var contacts = [Contact]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        contacts <- map["contacts"]
    }
}

struct Contact: Mappable {
    
    var name = ""
    var position = ""
    var number = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        position <- map["position"]
        number <- map["number"]
    }
}

struct NewTaxi: Mappable {
    
    var title = ""
    var phone_number = ""
    var additional_phone_number1 = ""
    var additional_phone_number2 = ""
    var email = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        title <- map["title"]
        phone_number <- map["phone_number"]
        additional_phone_number1 <- map["additional_phone_number1"]
        additional_phone_number2 <- map["additional_phone_number2"]
        email <- map["email"]
        
    }
    
}

struct NewAir: Mappable {
    
    var id = 0
    var title = ""
    var phone_number = ""
    var additional_phone_number1 = ""
    var additional_phone_number2 = ""
    var email = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        phone_number <- map["phone_number"]
        additional_phone_number1 <- map["additional_phone_number1"]
        additional_phone_number2 <- map["additional_phone_number2"]
        email <- map["email"]
        
    }
}
