//
//  HomeTestViewController.swift
//  ism
//
//  Created by DAS on 10/29/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit
import Cartography
import Toast_Swift
import PDFKit

protocol Reloadable {
    func reloadAfterInternetConnectionEstablished()
}

protocol DownloadProtocol {
    func downloadBook()
}

class HomeVC: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Reloadable, DownloadProtocol {
    
    var pdfURL: URL!
    
    func reloadAfterInternetConnectionEstablished() {
        getAboutUs()
    }
    
    func downloadBook() {
        
        if pdfURL != nil {
            DispatchQueue.main.async {
                let pdfViewController = PDFViewController()
                pdfViewController.pdfURL = self.pdfURL
                self.present(pdfViewController, animated: true, completion: nil)
                self.view.hideToastActivity()
                return
            }
        }
        
        guard let url = URL(string: manual[0].manual) else { return }
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        
        view.makeToastActivity(.center)
        let downloadTask = urlSession.downloadTask(with: url)
        
        downloadTask.resume()
        
        
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var home: [Home] = []
    
    var aboutUs = [AboutUs]()
    var manual = [Manual]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for family in UIFont.familyNames.sorted() {
//            let name = UIFont.fontNames(forFamilyName: family)
//            print("family \(family), fontName: \(name)")
//        }
        
        getAboutUs()
        getManual()
        
    }
    
    func setupViews() {
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        
        automaticallyAdjustsScrollViewInsets = false
        
        let heightOfStatusBar = UIApplication.shared.statusBarFrame.height
        collectionView.contentInset = UIEdgeInsets(top: -heightOfStatusBar, left: 0, bottom: 0, right: 0)
        
        home = [
            Home(title: "Contacts", icon: UIImage(named: "contacts"), position: 1),
            Home(title: "Applicant", icon: UIImage(named: "applicant"), position: 2),
            Home(title: "Academics", icon: UIImage(named: "academics"), position: 3),
            //            Home(title: "Library", icon:  UIImage(named: "library"), position: 1),
            
            Home(title: "ISM Student Counsil", icon: UIImage(named: "counsil"), position: 4),
            Home(title: "Passport and visa procedure", icon: UIImage(named: "passport"), position: 5),
            
            //            Home(title: "ISM Student Council", icon: UIImage(named: "training"), position: 6),
            ////            Home(title: "Events", icon: UIImage(named: "calendar"), position: 7),
            //            Home(title: "Video", icon: UIImage(named: "video"), position: 8),
            //            Home(title: "Air Ticket", icon: UIImage(named: "tickets"), position: 9),
            //            Home(title: "Taxi", icon: UIImage(named: "taxi"), position: 10),
            Home(title: "Maps", icon: UIImage(named: "maps"), position: 6)
        ]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func getAboutUs() {
        view.makeToastActivity(.center)
        ApiInteractor.shared.getAboutUs { (response, errString) in
            self.view.hideToastActivity()
            if errString == nil {
                if let data = response {
                    self.aboutUs = data
                    self.setupViews()
                }
            } else {
                self.internetErrorAlert(message: errString, reloadable: self)
            }
        }
    }
    
    func getManual() {
        view.makeToastActivity(.center)
        ApiInteractor.shared.getManual { (response, errString) in
            self.view.hideToastActivity()
            if errString == nil {
                if let data = response {
                    self.manual = data
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return home.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            return cell
        }
        
        let cellHome = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! CollectionViewCell
        cellHome.item = home[indexPath.item]
        cellHome.layer.cornerRadius = 5
        
        return cellHome
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as! FooterCell
        cell.aboutUs = aboutUs[0]
        cell.downloadDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        }
        return CGSize(width: view.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            collectionView.sendSubviewToBack(cell)
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: view.bounds.width, height: 250)
        }
        
        var height = UIScreen.main.bounds.size.width/2/3+20+12+40+20
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            height += 12
        }
        
        return CGSize(width: UIScreen.main.bounds.size.width/2 - 33, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: -70, left: 24, bottom: 24, right: 24)
    }
    
    // horizontal
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }

    // vertical
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if let url = URL(string: aboutUs[0].website) {
                UIApplication.shared.open(url)
            }
            return
        }
        
        if (self.home[indexPath.item].position == 1) {
            
            let contactsVC = ContactsVC()
            let navC = UINavigationController(rootViewController: contactsVC)
            self.present(navC, animated: true)
            
//            let libraryVC = UIStoryboard(name: "LibraryVC", bundle: nil).instantiateInitialViewController() as! LibraryVC
//            let navC = UINavigationController(rootViewController: libraryVC)
//            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 2){
        
////            let applicantVC = UIStoryboard(name: "ApplicantVC", bundle: nil).instantiateInitialViewController() as! ApplicantVC
////            let navC = UINavigationController(rootViewController: applicantVC)
//
//            self.present(navC, animated: true, completion: nil)
//
//            let letterVC = UIStoryboard(name: "LetterVC", bundle: nil).instantiateInitialViewController() as! LetterVC
//            let navC = UINavigationController(rootViewController: letterVC)
//
//            self.present(navC, animated: true, completion: nil)
            
            let applicantVC = ApplicantVC()
            let navC = UINavigationController(rootViewController: applicantVC)
            self.present(navC, animated: true)

        } else if (self.home[indexPath.item].position == 3) {
            
            let academicsVC = AcademicsVC()
            self.present(academicsVC, animated: true)
//            
//            let contactsVC = UIStoryboard(name: "ContactsVC", bundle: nil).instantiateInitialViewController() as! ContactsVC
//            let navC = UINavigationController(rootViewController: contactsVC)
//
//            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 4) {
            
            let vc = CouncilVC()
            let navBar = UINavigationController(rootViewController: vc)
            present(navBar, animated: true)
            
        } else if (self.home[indexPath.item].position == 5) {
            
            let vc = PassportViewController()
            let navC = UINavigationController(rootViewController: vc)
            
            present(navC, animated: true)

//            let passportVC = UIStoryboard(name: "PassportVC", bundle: nil).instantiateInitialViewController() as! PassportVC
//            let navC = UINavigationController(rootViewController: passportVC)
//
//            self.present(navC, animated: true, completion: nil)
        } else if (self.home[indexPath.item].position == 6) {
            
//            let ismStudentVC = UIStoryboard(name: "IsmStudentVC", bundle: nil).instantiateInitialViewController() as! IsmStudentVC
//            let navC = UINavigationController(rootViewController: ismStudentVC)
//
//            self.present(navC, animated: true, completion: nil)
            
            let mapsVC = Maps()
            let navC = UINavigationController(rootViewController: mapsVC)
            self.present(navC, animated: true)
            
        } else if(self.home[indexPath.item].position == 8){
            
            let videoVC = UIStoryboard(name: "VideoVC", bundle: nil).instantiateInitialViewController() as! VideoVC
            let navC = UINavigationController(rootViewController: videoVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 9) {
            
            let ticketVC = UIStoryboard(name: "TicketVC", bundle: nil).instantiateInitialViewController() as! TicketVC
            let navC = UINavigationController(rootViewController: ticketVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 10) {
            
            let taxiVC = UIStoryboard(name: "TaxiVC", bundle: nil).instantiateInitialViewController() as! TaxiVC
            let navC = UINavigationController(rootViewController: taxiVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 7) {
            
            let eventsDetailVC = UIStoryboard(name: "EventsDetailVC", bundle: nil).instantiateInitialViewController() as! EventsDetailVC
            let navC = UINavigationController(rootViewController: eventsDetailVC)
            
            self.present(navC, animated: true, completion: nil)
            
        } else if (self.home[indexPath.item].position == 11) {
            
            let newMapsVC = NewMapsVC()
            let navC = UINavigationController(rootViewController: newMapsVC)
            
            self.present(navC, animated: true, completion: nil)
            
        }
    }

}

extension HomeVC:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.pdfURL = destinationURL
            DispatchQueue.main.async {
                let pdfViewController = PDFViewController()
                pdfViewController.pdfURL = self.pdfURL
                self.present(pdfViewController, animated: false, completion: nil)
                self.view.hideToastActivity()
            }
            
            
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}
