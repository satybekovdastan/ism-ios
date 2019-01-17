//
//  AboutPageViewController.swift
//  ism
//
//  Created by DAS on 10/26/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Toast_Swift
import Cartography

class AboutPageViewController: UIViewController, Reloadable {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAbout()
        navigationItem.title = "ISM"
        
        view.addSubview(instagramButton)
        view.addSubview(facebookButton)
        
        constrain(instagramButton, facebookButton, label) { instagramButton, facebookButton, label in
            
            facebookButton.top == label.bottom + 45
            facebookButton.left == facebookButton.superview!.left + 45
            facebookButton.height == 100
            facebookButton.width == 100
            
            instagramButton.top == label.bottom + 45
            instagramButton.right == instagramButton.superview!.right - 45
            instagramButton.height == 100
            instagramButton.width == 100
            
            
            
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(instagramButtonTapped))
        instagramButton.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(facebookButtonTapped))
        facebookButton.addGestureRecognizer(tap1)
    }
    
    @objc func instagramButtonTapped() {
        let instagramHooks = "instagram://user?username=ism_official.kg"
        let instagramUrl = URL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl!) {
            UIApplication.shared.open(instagramUrl!)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(URL(string: "http://instagram.com/")!)
        }
    }
    
    @objc func facebookButtonTapped() {
        let facebookUrl = URL(string: "https://m.facebook.com/International-School-of-Medicine-Bishkek-Kyrgyzstan-156026607865633/")
        if UIApplication.shared.canOpenURL(facebookUrl!) {
            UIApplication.shared.open(facebookUrl!)
        } else {
            print("cannot open url")
        }
    }
    
    
    
    var instagramButton: UIImageView = {
        let button = UIImageView()
        button.isUserInteractionEnabled = true
        
        button.image = UIImage(named: "instagram")?.withRenderingMode(.alwaysOriginal)
        button.contentMode = .scaleAspectFill
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var facebookButton: UIImageView = {
        
        let button = UIImageView()
        button.isUserInteractionEnabled = true
        
        button.image = UIImage(named: "facebook")?.withRenderingMode(.alwaysOriginal)
        button.contentMode = .scaleAspectFill
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    func getAbout() {
        self.view.makeToastActivity(.center)
        ApiInteractor.shared.getAbout{ (response, errorString) in
            self.view.hideToastActivity()
            if errorString == nil {
                if let data = response {
                    var items = [About]()
                    items = data;
                    print("info", "\([items[0].text])")
                    self.label.text = items[0].text.htmlToString
                
                }
            } else {
                self.internetErrorAlert(message: errorString, reloadable: self)
            }
        }
    }
    
    func reloadAfterInternetConnectionEstablished() {
        self.getAbout()
    }

}
