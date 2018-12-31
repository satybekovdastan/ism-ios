//
//  ContatcViewController.swift
//  ism
//
//  Created by DAS on 11/2/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import WebKit
import GoogleMaps
import Toast_Swift

class ContactVC: UIViewController, Reloadable {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneLabel2: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var number:String = ""
    var number2:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getContact()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ContactVC.tapFunction))
        phoneLabel.isUserInteractionEnabled = true
        phoneLabel.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction2))
        self.phoneLabel2.isUserInteractionEnabled = true
        self.phoneLabel2.addGestureRecognizer(tap2)
       
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Bishkek"
        marker.snippet = addressLabel.text
        marker.map = mapView
    }

    func getContact() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getContact{ (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                if let data = response {
                    var items = [Contact]()
                    items = data;
                    
                    let camera = GMSCameraPosition.camera(withLatitude: items[0].latitude, longitude: items[0].longitude, zoom: 15.0)
                    self.mapView.camera = camera
                    self.showMarker(position: camera.target)
                    
                    self.addressLabel.text = items[0].address
                    self.phoneLabel.text = items[0].phone_number
                    self.phoneLabel2.text = items[0].additional_phone_number2
                    self.emailLabel.text = items[0].email

                   
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        }
    }
    
    func reloadAfterInternetConnectionEstablished() {
        self.getContact()
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print("tap")
        guard let number = URL(string: "tel://" + "+99556565656") else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func tapFunction2(sender:UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + phoneLabel2.text!) else { return }
        UIApplication.shared.open(number)
    }
}
