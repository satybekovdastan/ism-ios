//
//  ContatcViewController.swift
//  ism
//
//  Created by DAS on 11/2/18.
//  Copyright © 2018 sunrise. All rights reserved.
//
//
//import UIKit
//import Toast_Swift
//import MapKit
//import Cartography
//
//class MapsVC: UIViewController, Reloadable, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
//
//    var number:String = ""
//    var number2:String = ""
//
//    var items = [Contact]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(mapView)
//
//        navigationItem.title = "ISM"
//
//        collectionView.register(MapsCVCell.self, forCellWithReuseIdentifier: "mapsCell")
//
//    }
//
//    func addCollectionView() {
//        view.addSubview(collectionView)
//
//        constrain(mapView, collectionView) { mapView, collectionView in
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
//        collectionView.reloadData()
//    }
//
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.backgroundColor = .white
//
//        cv.delegate = self
//        cv.dataSource = self
//
//        return cv
//    }()
//
//    let mapView: MKMapView = {
//        let mv = MKMapView()
//        mv.translatesAutoresizingMaskIntoConstraints = false
//
//        return mv
//
//    }()
//
//    func getContact() {
//        self.view.makeToastActivity(.center)
//        ApiInteractor.shared.getContact{ (response, errorString) in
//            self.view.hideToastActivity()
//            if errorString == nil {
//                if let data = response {
//                    self.items = data
//
//                    self.addCollectionView()
//
//                    let center = CLLocationCoordinate2D(latitude: self.items[0].latitude, longitude: self.items[0].longitude)
//                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//                    self.mapView.setRegion(region, animated: true)
//
//                    var annotations = [MKAnnotation]()
//
//                    for i in 0..<self.items.count {
//                        print(i)
//                        let location = CLLocationCoordinate2D(latitude: self.items[i].latitude, longitude: self.items[i].longitude)
//                        let pin = CustomPin(pinTitle: self.items[i].address, location: location)
//                        annotations.append(pin)
//
////                        let annotation = MKPointAnnotation()
////                        let location = CLLocation(latitude: self.items[i].latitude, longitude: self.items[i].longitude)
////                        annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
////                        annotations.append(annotation)
//
//                    }
//
//                    self.mapView.addAnnotations(annotations)
//
//
//                }
//            } else {
//                self.internetErrorAlert(message: errorString, reloadable: self)
//            }
//        }
//    }
//
//    func reloadAfterInternetConnectionEstablished() {
//        self.getContact()
//    }
//
////    @IBAction func phoneLabelTapped(_ sender: Any) {
////        guard let number = URL(string: "tel://" + "\(phoneLabel.text!.replacingOccurrences(of: " ", with: ""))") else { return }
////
////        UIApplication.shared.open(number)
////    }
////
////    @IBAction func phoneLabel2Tapped(_ sender: Any) {
////        guard let number = URL(string: "tel://" + "\(phoneLabel2.text!.replacingOccurrences(of: " ", with: ""))") else { return }
////
////        UIApplication.shared.open(number)
////    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let center = CLLocationCoordinate2D(latitude: self.items[indexPath.item].latitude, longitude: self.items[indexPath.item].longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
//        self.mapView.setRegion(region, animated: true)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapsCell", for: indexPath) as! MapsCVCell
//        cell.item = items[indexPath.item]
//        cell.clipsToBounds = true
//
//        return cell
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        if (items[indexPath.item].phone_number != "" || items[indexPath.item].additional_phone_number1 != "") && items[indexPath.item].email == "" {
//            return CGSize(width: Int(UIScreen.main.bounds.width), height: 130)
//        }
//        if items[indexPath.item].phone_number == "" && items[indexPath.item].additional_phone_number1 == "" && items[indexPath.item].email == "" {
//            return CGSize(width: Int(UIScreen.main.bounds.width), height: 80)
//        }
//
//        return CGSize(width: Int(UIScreen.main.bounds.width), height: 150)
//    }
//
//    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//    //        return 10
//    //    }
//
//    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    //        return 10
//    //    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.getContact()
//    }
//
//}
//
//extension MapsVC: MKMapViewDelegate {
//
//
//
//}
