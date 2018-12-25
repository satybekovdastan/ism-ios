//
//  ApiInteractor.swift
//  Checkin
//
//  Created by Artem Kirnos on 12/15/17.
//  Copyright © 2017 sunriseStudio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

private let baseUrl = Constaints.kServerPath

class ApiInteractor: NSObject {
    
    static let shared = ApiInteractor()
    
    // MARK: - CHECK INTERNET CONNECTION
    
    private func connectCheck(result:@escaping (_ message:String) -> Void) {
        if !NetworkReachabilityManager()!.isReachableOnEthernetOrWiFi && !NetworkReachabilityManager()!.isReachableOnWWAN {
            result("Включите Wi-Fi или \"Мобильные данные\" и повторите попытку")
        } else {
            checkInternetConnection(result: { (isConnect) in
                if isConnect {
                    result("Ошибка на сервере. Подождите немного и повторите попытку")
                } else {
                    result("У вас нет доступа к интернету. Пожалуйста проверте интернет соединение и повторите попытку")
                }
            })
        }
    }
    
    private func checkInternetConnection(result:@escaping (_ isConnected: Bool) -> Void) {
        let request = URLRequest(url: URL(string: "https://www.google.com/")!)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {_, _, error -> Void in
            var isConnected = false
            if error != nil, let err = error as NSError? {
                if err.code == -1009 {
                    isConnected = false
                }
            } else if error == nil {
                isConnected = true
            }
            result(isConnected)
        })
        task.resume()
    }
    
    
    // MARK: - GET SPECIALISTS/INSTITUTE LIST
    
    public func getTickets(success:@escaping(_ items:Tickets?, String?) -> Void) {
        _ = String(format: "/v1/core/tickets/", baseUrl)
        
        Alamofire.request("http://ism-app.sunrisetest.site/api/v1/core/tickets/", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response: DataResponse<Tickets>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getFavorites(success:@escaping(_ items:[Tickets]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/core/tickets/")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Tickets]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    
    
    public func getTaxi(success:@escaping(_ items:[Tickets]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/core/taxi/")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Tickets]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getLibrary(success:@escaping(_ items:[Library]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/core/books/")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Library]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getStudents(success:@escaping(_ items:[Student]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/students/contacts")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Student]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getEvents(success:@escaping(_ items:[Event]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/core/events/")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Event]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getAbout(success:@escaping(_ items:[About]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/page/about")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[About]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    
    public func getContact(success:@escaping(_ items:[Contact]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/page/contacts")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Contact]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getPassportVisa(success:@escaping(_ items:[Passport]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/page/passport_and_visa")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Passport]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getVideo(success:@escaping(_ items:[Video]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/core/videos/")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Video]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getGroup(success:@escaping(_ items:[Group]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/students/group")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Group]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getSemester(success:@escaping(_ items:[Semester]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/students/semesters")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Semester]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
    
    public func getSchedule(groupId: Int, semesterId: Int, success: @escaping(_ items:[Schedule]?, String?) -> Void) {
        let url = String(format: "http://ism-app.sunrisetest.site/api/v1/students/schedule?groups=\(groupId)&semester=\(semesterId)")
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        Alamofire.request(encodedString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray { (response: DataResponse<[Schedule]>) in
            switch response.result {
            case .success(let response):
                success(response, nil)
            case .failure:
                self.connectCheck(result: { (message) in
                    success(nil, message)
                })
            }
        }
    }
}
