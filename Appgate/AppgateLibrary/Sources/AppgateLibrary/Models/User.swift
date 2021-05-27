//
//  File.swift
//  
//
//  Created by Yony Gonzalez Vargas on 23/05/21.
//

import Foundation

public struct User
{
    ///
    public var login: String
    ///
    public var password: String
    
    /**
 
    */
    public init(named login: String, withPassword password: String)
    {
        self.login = login
        self.password = password
    }
}

//
// MARK: - CustomStringConvertible Protocol
//
extension User: CustomStringConvertible
{
    ///
    public var description: String
    {
        return "User with login \(self.login) has the password \(self.password)"
    }
}
