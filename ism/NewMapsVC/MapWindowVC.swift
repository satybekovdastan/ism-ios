//
//  MapWindowVC.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/1/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

//import UIKit
//import MKMapKit
//import Cartography
//
//class MapWindowVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(mapView)
//
//        constrain(mapView) { mapView in
//
//            mapView.left == mapView.superview!.left
//            mapView.top == mapView.superview!.top
//            mapView.right == mapView.superview!.right
//            mapView.height == 350
//
//            collectionView.top == mapView.bottom
//            collectionView.left == collectionView.superview!.left
//            collectionView.right == collectionView.superview!.right
//            collectionView.bottom == collectionView.superview!.bottom
//
//        }
//
//    }
//
//    let mapView: MKMapView = {
//        let mv = MKMapView()
//        mv.translatesAutoresizingMaskIntoConstraints = false
//
//        return mv
//
//    }()
//
//}
