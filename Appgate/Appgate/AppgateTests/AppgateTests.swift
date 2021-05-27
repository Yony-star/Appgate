//
//  AppgateTests.swift
//  AppgateTests
//
//  Created by Yony Gonzalez Vargas on 23/05/21.
//

import XCTest
@testable import Appgate
@testable import AppgateLibrary

class AppgateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetTimeFromApiRequest() throws{
        
        // Bogota Appgate Office Location
        let latitude = "4.683305"
        let longitude = "-74.047032"
        
        let promise = expectation(description: "Value Received")
        
        TimeServiceAPI.shared.fetchTime(lat: latitude, lng: longitude) { (result: Result<EventTime, TimeServiceAPI.APIServiceError>) in
            switch result {
                case .success(let eventTime):
            
                    XCTAssertEqual(eventTime.lat, 4.683305)
                    XCTAssertEqual(eventTime.lng, -74.047032)
                    XCTAssertEqual(eventTime.countryCode, "CO")
                    
                    promise.fulfill()
                    

                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
        wait(for: [promise], timeout: 5)
    
    }
    
    static var allTests = [
        ("testGetTimeFromApiRequest", testGetTimeFromApiRequest),
        
        
    ]

}
