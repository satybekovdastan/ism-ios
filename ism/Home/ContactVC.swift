//
//  ContatcViewController.swift
//  ism
//
//  Created by DAS on 11/2/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift
import MapKit

class ContactVC: UIViewController, Reloadable {
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneLabel2: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var number:String = ""
    var number2:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello")
        self.getContact()

        
        navigationItem.title = "ISM"
       
    }

    func getContact() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getContact{ (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                if let data = response {
                    var items = [Contact]()
                    items = data;
                    print(items.count)

                    let center = CLLocationCoordinate2D(latitude: items[0].latitude, longitude: items[0].longitude)
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    self.mapView.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: items[0].latitude, longitude: items[0].longitude)
                    self.mapView.addAnnotation(annotation)
                    
                    self.addressLabel.text = items[0].address
                    self.phoneLabel.text = items[0].phone_number
                    self.phoneLabel2.text = items[0].additional_phone_number1
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
    
    @IBAction func phoneLabelTapped(_ sender: Any) {
        guard let number = URL(string: "tel://" + "\(phoneLabel.text!.replacingOccurrences(of: " ", with: ""))") else { return }
        
        UIApplication.shared.open(number)
    }
    
    @IBAction func phoneLabel2Tapped(_ sender: Any) {
        guard let number = URL(string: "tel://" + "\(phoneLabel2.text!.replacingOccurrences(of: " ", with: ""))") else { return }
        
        UIApplication.shared.open(number)
    }
}
