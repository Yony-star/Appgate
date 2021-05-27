//
//  AppgateUITests.swift
//  AppgateUITests
//
//  Created by Yony Gonzalez Vargas on 23/05/21.
//

import XCTest
@testable import AppgateLibrary
@testable import Appgate

class AppgateUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginFails() throws {

        
        let app = XCUIApplication()
        app.launch()
        

        XCTAssert(app.enterUserLabel.exists)
        XCTAssertEqual(app.enterUserLabel.label, "Please enter your user below")
        
        XCTAssert(app.textfieldAccount.exists)
        XCTAssertEqual(app.textfieldAccount.placeholderValue, "email@domain.com")
        
        XCTAssert(app.labelMessage.exists)
        XCTAssertEqual(app.labelMessage.label, "Welcome")

        
        let expectation = "yony@appgate.com"
        
        app.textfieldAccount.tap()
        app.textfieldAccount.typeText(expectation)
        
        XCTAssertEqual(app.textfieldAccount.value as! String, expectation)
        
        app.buttonLogin.tap()
        
        //TODO: FIX ERROR
//        let element = app.staticTexts["label-message"]
//        self.waitForElementToAppear(element: element, timeout: 10)
//        XCTAssertEqual(element.value as? String, "")
//
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 5,  file: String = #file, line: UInt = #line) {
            let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate,
                    evaluatedWith: element, handler: nil)

        waitForExpectations(timeout: timeout) { (error) -> Void in
                if (error != nil) {
                    let message = "Failed to find \(element) after \(timeout) seconds."
                    self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
                }
            }
        }
    
}


private extension XCUIApplication {
    var enterUserLabel: XCUIElement { self.staticTexts["enter-user-label"] }
    var labelMessage: XCUIElement { self.staticTexts["label-message"] }
    var textfieldAccount: XCUIElement { self.textFields["text-field-account"] }
    var textfieldPassword: XCUIElement { self.textFields["text-field-password"] }
    var buttonLogin: XCUIElement { self.buttons["button-login"] }
}


