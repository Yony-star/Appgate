import XCTest
@testable import AppgateLibrary

final class AppgateLibraryTests: XCTestCase {
    
    
    func testLoginUserNotRegistered() {
        var appgateLibrary = AppgateLibrary()

        let user =  User(named:"User",withPassword: "p1" )
        let eventCompare = Event(user: user, success: AuthError.fail, message: EventCode.E002.rawValue, eventCode: EventCode.E002)
        let eventResponse = appgateLibrary.AuthGetCredetials(login: "User", password: "p1")
        
        XCTAssertEqual(eventResponse.eventCode.rawValue, eventCompare.eventCode.rawValue)
        XCTAssertEqual(eventResponse.message, "Error E002 - Login: User not registered, password does not exist.")
        XCTAssertEqual(eventResponse.user.login, "")
        XCTAssertEqual(eventResponse.success, eventCompare.success)

    }
    
    
    func testLoginPassword1NotMatchPasword2() {

        var appgateLibrary = AppgateLibrary()

        let user =  User(named:"User",withPassword: "p1" )
        let eventCompare = Event(user: user, success: AuthError.fail, message: EventCode.E009.rawValue, eventCode: EventCode.E009)
        let eventResponse = appgateLibrary.AuthSaveCredetials(login: "User", password1: "p1", password2: "p2")
        
        XCTAssertEqual(eventResponse.eventCode.rawValue, eventCompare.eventCode.rawValue)
        XCTAssertEqual(eventResponse.message, "Error E009 - Signup: Password confirmation must match Password.")
        XCTAssertEqual(eventResponse.user.login, "")
        XCTAssertEqual(eventResponse.success, eventCompare.success)
        
    }
    

    
    

    static var allTests = [
        ("testLoginUserNotRegistered", testLoginUserNotRegistered),
        ("testLoginPassword1NotMatchPasword2", testLoginPassword1NotMatchPasword2),
        
    ]
}
