//
//  ApiSkipDataProvider.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RxSwift

class ApiSkipDataprovider{
    static let sharedInstance = ApiSkipDataprovider()
    
    let baseUrl = "https://api-vanhack-event-sp.azurewebsites.net"
    let baseCousineUrl = "/api/v1/Cousine"
    let baseCustomerUrl = "/api/v1/Customer"
    let baseOrderUrl = "/api/v1/Order"
    let baseStoreUrl = "/api/v1/Store"
    let userToken = UserDefaults.standard.object(forKey: "token") as? String

    func getCousines(searchString: String = "") -> Observable<[Cousine]>
    {
        var url = "\(baseUrl)\(baseCousineUrl)"
        if searchString != "" {
            url.append("/search/\(searchString)")
        }
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(url).responseJSON { response in
                switch(response.result){
                case .success(_):
                    if let statusCode = response.response?.statusCode, statusCode == 200{
                        do{
                            let cousineArray = try JSONDecoder().decode([Cousine].self, from: response.data!)
                            observer.onNext(cousineArray)
                            observer.onCompleted()
                        }catch{
                            print("Error geting cousines: \(error.localizedDescription)")
                            observer.onError(error)
                        }
                    }else{
                        print("Wrong response status code: \(response.response?.statusCode ?? -1)")
                        observer.onError(NSError(domain: "myDomain", code: response.response?.statusCode ?? -1, userInfo: nil))
                    }
                case .failure(let error):
                    print("An error ocurred: \(error.localizedDescription)")
                    observer.onError(NSError(domain: "myDomain", code: -1, userInfo: nil))
                }
            }
            return Disposables.create{
                request.cancel()
            }
        })
    }
    
    func getRestaurants(searchString: String = "") -> Observable<[Restaurant]>
    {
        var url = "\(baseUrl)\(baseStoreUrl)"
        if searchString != "" {
            url.append("/search/\(searchString)")
        }
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(url).responseJSON { response in
                switch(response.result){
                case .success(_):
                    if let statusCode = response.response?.statusCode, statusCode == 200{
                        do{
                            let cousineArray = try JSONDecoder().decode([Restaurant].self, from: response.data!)
                            observer.onNext(cousineArray)
                            observer.onCompleted()
                        }catch{
                            print("Error geting cousines: \(error.localizedDescription)")
                            observer.onError(error)
                        }
                    }else{
                        print("Wrong response status code: \(response.response?.statusCode ?? -1)")
                        observer.onError(NSError(domain: "myDomain", code: response.response?.statusCode ?? -1, userInfo: nil))
                    }
                case .failure(let error):
                    print("An error ocurred: \(error.localizedDescription)")
                    observer.onError(NSError(domain: "myDomain", code: -1, userInfo: nil))
                }
            }
            return Disposables.create{
                request.cancel()
            }
        })
    }
    
    //MARK:- Products
    func getProducts(restaurantID: Int) -> Observable<[Product]>
    {
        let url = "\(baseUrl)\(baseStoreUrl)/\(restaurantID)/products"
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(url).responseJSON { response in
                switch(response.result){
                case .success(_):
                    if let statusCode = response.response?.statusCode, statusCode == 200{
                        do{
                            let productsArray = try JSONDecoder().decode([Product].self, from: response.data!)
                            observer.onNext(productsArray)
                            observer.onCompleted()
                        }catch{
                            print("Error geting cousines: \(error.localizedDescription)")
                            observer.onError(error)
                        }
                    }else{
                        print("Wrong response status code: \(response.response?.statusCode ?? -1)")
                        observer.onError(NSError(domain: "myDomain", code: response.response?.statusCode ?? -1, userInfo: nil))
                    }
                case .failure(let error):
                    print("An error ocurred: \(error.localizedDescription)")
                    observer.onError(NSError(domain: "myDomain", code: -1, userInfo: nil))
                }
            }
            return Disposables.create{
                request.cancel()
            }
        })
    }
    
    //MARCK:- Order
    
    func postOrder(order: Order) -> Observable<Order>
    {
        let url = "\(baseUrl)\(baseOrderUrl)"
        let encodedData = try? JSONEncoder().encode(order)
        let encodedString = try? JSONSerialization.jsonObject(with: encodedData!, options: .allowFragments) as? [String: Any]
        
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(URL.init(string: url)!, method: .post, parameters: encodedString!, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(self.userToken!)"]).responseString{ response in
                switch(response.result){
                case .success(_):
                    if let statusCode = response.response?.statusCode, statusCode == 200{
                        observer.onNext(order)
                        observer.onCompleted()
                    }else{
                        print("Wrong response status code: \(response.response?.statusCode ?? -1)")
                        observer.onError(NSError(domain: "myDomain", code: response.response?.statusCode ?? -1, userInfo: nil))
                    }
                case .failure(let error):
                    print("An error ocurred: \(error.localizedDescription)")
                    observer.onError(NSError(domain: "myDomain", code: -1, userInfo: nil))
                }
            }
            return Disposables.create{
                request.cancel()
            }
        })
    }
    
    func getOrders() -> Observable<[Order]>
    {
        let url = "\(baseUrl)\(baseOrderUrl)/customer"
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(URL.init(string: url)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(self.userToken!)"]).responseJSON { response in
                switch(response.result){
                case .success(_):
                    if let statusCode = response.response?.statusCode, statusCode == 200{
                        do{
                            let orderArray = try JSONDecoder().decode([Order].self, from: response.data!)
                            observer.onNext(orderArray)
                            observer.onCompleted()
                        }catch{
                            print("Error geting orders: \(error.localizedDescription)")
                            observer.onError(error)
                        }
                    }else{
                        print("Wrong response status code: \(response.response?.statusCode ?? -1)")
                        observer.onError(NSError(domain: "myDomain", code: response.response?.statusCode ?? -1, userInfo: nil))
                    }
                case .failure(let error):
                    print("An error ocurred: \(error.localizedDescription)")
                    observer.onError(NSError(domain: "myDomain", code: -1, userInfo: nil))
                    }
                }
            return Disposables.create{
                request.cancel()
            }
        })
    }
    
    //MARK:- Customer
    func getCustomer(email: String, password: String) -> Observable<Customer>
    {
        var url = "\(baseUrl)\(baseCustomerUrl)"
        if email != "" && password != ""{
            url.append("/auth?email=\(email)&password=\(password)")
        }
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(url, method: HTTPMethod.post).responseString { response in
                switch(response.result){
                case .success(let stringResponse):
                    if let statusCode = response.response?.statusCode, statusCode == 200{
                        UserDefaults.standard.set(stringResponse, forKey: "token")
                        UserDefaults.standard.set(email, forKey: "email")
                        
                        //API just return token of user, should have returned the complete user information... What if is the first time loging in from this device?
                        let dummyObj = Customer.init(id: 0, email: email, name: "", address: "", creation: Utils.nowTimeStamp(), password: password)
                        observer.onNext(dummyObj)
                        
                        observer.onCompleted()
                    }else{
                        print("Wrong response status code: \(response.response?.statusCode ?? -1)")
                        observer.onError(NSError(domain: "myDomain", code: response.response?.statusCode ?? -1, userInfo: nil))
                    }
                case .failure(let error):
                    print("An error ocurred: \(error.localizedDescription)")
                    observer.onError(NSError(domain: "myDomain", code: -1, userInfo: nil))
                }
            }
            return Disposables.create{
                request.cancel()
            }
        })
    }
    
    func postCustomer(customer: Customer) -> Observable<Customer>
    {
        let url = "\(baseUrl)\(baseCustomerUrl)"
        let encodedData = try? JSONEncoder().encode(customer)
        let encodedString = try? JSONSerialization.jsonObject(with: encodedData!, options: .allowFragments) as? [String: Any]
        
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(URL.init(string: url)!, method: .post, parameters: encodedString!, encoding: JSONEncoding.default, headers: nil).responseString{ response in
                switch(response.result){
                case .success(let stringResponse):
                    if let statusCode = response.response?.statusCode, statusCode == 200{
                        UserDefaults.standard.set(stringResponse, forKey: "token")
                        UserDefaults.standard.set(customer.name, forKey: "name")
                        UserDefaults.standard.set(customer.address, forKey: "address")
                        UserDefaults.standard.set(customer.email, forKey: "email")
                        observer.onNext(customer)
                        observer.onCompleted()
                    }else{
                        print("Wrong response status code: \(response.response?.statusCode ?? -1)")
                        observer.onError(NSError(domain: "myDomain", code: response.response?.statusCode ?? -1, userInfo: nil))
                    }
                case .failure(let error):
                    print("An error ocurred: \(error.localizedDescription)")
                    observer.onError(NSError(domain: "myDomain", code: -1, userInfo: nil))
                }
            }
            return Disposables.create{
                request.cancel()
            }
        })
    }
}
