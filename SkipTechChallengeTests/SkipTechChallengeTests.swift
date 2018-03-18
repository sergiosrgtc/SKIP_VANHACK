//
//  SkipTechChallengeTests.swift
//  SkipTechChallengeTests
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import XCTest
import SwiftyJSON
import Alamofire

@testable import SkipTechChallenge

class SkipTechChallengeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCousine() {
        let e = expectation(description: "Alamofire")

        let baseUrl = "https://api-vanhack-event-sp.azurewebsites.net"
        let baseCousineUrl = "/api/v1/Cousine"
        
        let url = "\(baseUrl)\(baseCousineUrl)"
        
        Alamofire.request(url).responseJSON { (response) in
            XCTAssertNotNil(response, "No response")
            switch(response.result){
                
            case .success(_):
                XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
                if let statusCode = response.response?.statusCode, statusCode == 200{
                    let cousine = try! JSONDecoder().decode([Cousine].self, from: response.data!)
                    cousine.forEach { print($0) }
                }
            case .failure(_):
                XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testOrder() {
        let e = expectation(description: "Alamofire")
        
        let baseUrl = "https://api-vanhack-event-sp.azurewebsites.net"
        let baseOrderUrl = "/api/v1/Order"
        
        let url = "\(baseUrl)\(baseOrderUrl)"
        
        Alamofire.request(url).responseJSON { (response) in
            XCTAssertNotNil(response, "No response")
            
            switch(response.result){
                
            case .success(let data):
                XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
                if let statusCode = response.response?.statusCode, statusCode == 200{
                    let json = JSON(data)
                    print(json)
                }
            case .failure(_):
                XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testCustomer() {
        let e = expectation(description: "Alamofire")
        
        let baseUrl = "https://api-vanhack-event-sp.azurewebsites.net"
        let baseCustomerUrl = "/api/v1/Customer"
        
        let url = "\(baseUrl)\(baseCustomerUrl)"
        
        Alamofire.request(url).responseJSON { (response) in
            XCTAssertNotNil(response, "No response")
            
            switch(response.result){
                
            case .success(let data):
                XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
                if let statusCode = response.response?.statusCode, statusCode == 200{
                    let json = JSON(data)
                    print(json)
                }
            case .failure(_):
                XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testStore() {
        let e = expectation(description: "Alamofire")
        
        let baseUrl = "https://api-vanhack-event-sp.azurewebsites.net"
        let baseStoreUrl = "/api/v1/Store"
        
        let url = "\(baseUrl)\(baseStoreUrl)"
        
        Alamofire.request(url).responseJSON { (response) in
            XCTAssertNotNil(response, "No response")
            
            switch(response.result){
                
            case .success(let data):
                XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
                if let statusCode = response.response?.statusCode, statusCode == 200{
                    let json = JSON(data)
                    print(json)
                }
            case .failure(_):
                XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
