//
//  Map.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/28/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit
import MapKit
import Cartography

class MapInternal: UIViewController {

    var campus: NewCampus? {
        didSet {
            let center = CLLocationCoordinate2D(latitude: self.campus!.latitude, longitude: self.campus!.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            self.mapView.setRegion(region, animated: true)

            let location = CLLocationCoordinate2D(latitude: self.campus!.latitude, longitude: self.campus!.longitude)
            let pin = CustomPin(pinTitle: campus!.address, location: location)

            self.mapView.addAnnotation(pin)

            setupViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func setupViews() {
    
        view.addSubview(mapView)

        constrain(mapView) { mapView in

            mapView.top == mapView.superview!.top
            mapView.left == mapView.superview!.left
            mapView.right == mapView.superview!.right
            mapView.bottom == mapView.superview!.bottom

        }
    }

    let mapView: MKMapView = {
        
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false

        return mv

    }()
}
