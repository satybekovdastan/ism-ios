//
//  CustomPin.swift
//  ism
//
//  Created by Atay Sultangaziev on 1/17/19.
//  Copyright © 2019 sunrise. All rights reserved.
//
//

import UIKit
import MapKit

class CustomPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(pinTitle: String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.coordinate = location
    }
    
}
