import Foundation

import CryptoKit
import Security
import SwiftUI
 
public struct AppgateLibrary {
    private let dataSecurity = DataSecurity()
    private var user : User!
    private var event : Event!
    
    public init(){
        self.user = User(named: "", withPassword: "")
        self.event = Event(user: User(named: "", withPassword: ""), success: AuthError.unknown, message: "", eventCode: EventCode.E005)
    }
    

    public mutating func AuthSaveCredetials( login: String, password1: String, password2: String) -> Event  {
        
        self.event = Event(user: User(named: "", withPassword: ""), success: AuthError.unknown, message: "", eventCode: EventCode.E000)
        
        if (login.isEmpty || password1.isEmpty  || password1.isEmpty){
            self.event.message = EventCode.E008.rawValue
            self.event.eventCode = EventCode.E008
            self.event.success = AuthError.fail
            return self.event
        }
        
        if (password1  != password2){
            self.event.message = EventCode.E009.rawValue
            self.event.eventCode = EventCode.E009
            self.event.success = AuthError.fail
            return self.event
        }
        
        
        
        let user = User(named: login, withPassword: password1)
        
        do
        {
            if self.dataSecurity.existsUser(user)
            {
                //try self.dataSecurity.updateSecureUser(user)
                self.event.message = "\(EventCode.E000.rawValue) (User:\(login))"
                self.event.eventCode = EventCode.E000
                self.event.success = AuthError.fail
                self.event.user = user
                return self.event
            }
            else
            {
                try self.dataSecurity.saveSecureUser(user)
                self.event.message = EventCode.E012.rawValue
                self.event.eventCode = EventCode.E012
                self.event.success = AuthError.success
                
                self.event.user = user
                return self.event
            }
        }
        catch(KeychainError.malformedData)
        {
            self.event.message = EventCode.E007.rawValue
            self.event.eventCode = EventCode.E007
            self.event.success = AuthError.fail
            return self.event
        }
        catch(KeychainError.passwordNotFound)
        {
            self.event.message = EventCode.E006.rawValue
            self.event.eventCode = EventCode.E006
            self.event.success = AuthError.fail
            return self.event
        }
        catch(KeychainError.unknown(let status))
        {
            self.event.message = "\(EventCode.E005.rawValue) Status\(status)"
            self.event.eventCode = EventCode.E005
            self.event.success = AuthError.fail
            return self.event
        }
        catch
        {
            //TODO:
        }
        
//        self.event.message = EventCode.E011.rawValue
//        self.event.eventCode = EventCode.E011
//        self.event.success = AuthError.success
//        self.event.user = user
        
        return self.event

    }

    public mutating func AuthGetCredetials( login : String, password: String)-> Event {
        
        self.event = Event(user: User(named: "", withPassword: ""), success: AuthError.unknown, message: "", eventCode: EventCode.E000)
        
        if (login.isEmpty || password.isEmpty){
            self.event.message = EventCode.E010.rawValue
            self.event.eventCode = EventCode.E010
            self.event.success = AuthError.fail
            return self.event
        }
        

        let user = User(named: login, withPassword: password)
        
        self.event.user = User(named: "", withPassword: "")
        self.event.success = AuthError.fail
        
        let searchResult = self.dataSecurity.fetchUser(user)
        
        switch searchResult
        {
            case .success(let searchUser):
                if searchUser.password == user.password
                {
                    self.event.message = EventCode.E011.rawValue
                    self.event.eventCode = EventCode.E011
                    self.event.user = searchUser
                    self.event.success = AuthError.success
                }
                else
                {
                    self.event.message = EventCode.E001.rawValue
                    self.event.eventCode = EventCode.E001
                    self.event.success = AuthError.fail
                    
                }
        
            case .failure(let error):
                switch error
                {
                    case .passwordNotFound:
                        self.event.message = EventCode.E002.rawValue
                        self.event.eventCode = EventCode.E002
                        self.event.success = AuthError.fail
                        
                    case .malformedData:
                        self.event.message = EventCode.E003.rawValue
                        self.event.eventCode = EventCode.E003
                        self.event.success = AuthError.fail
                        
                    case .unknown(status: let status):
                        self.event.message = "\(EventCode.E004.rawValue) Status\(status)"
                        self.event.eventCode = EventCode.E004
                        self.event.success = AuthError.fail
                        
                }
        }
        
        
        return event
        
    }

    


    
    
    
}


