//
//  File.swift
//  
//
//  Created by Yony Gonzalez Vargas on 24/05/21.
//

/*
Abstract:
Errors that can be generated as a result of attempting user Auth.
*/
import Foundation
/// An error we can throw when something goes wrong.
public enum EventCode: String
{
    case E000 = "Error E000 - Signup: This username is already taken."
    case E001 = "Error E001 - Login: Password is not correct."
    case E002 = "Error E002 - Login: User not registered, password does not exist."
    case E003 = "Error E003 - Login: The content of the password is not readable."
    case E004 = "Error E004 - Login: Unknown fail on the key of the Keychain."
    case E005 = "Error E005 - Signup: Unknown fail on the key of the Keychain."
    case E006 = "Error E006 - Signup: Not exists password."
    case E007 = "Error E007 - Signup: The content of the password is not readable."
    case E008 = "Error E008 - Signup: User and/or password is/are empty."
    case E009 = "Error E009 - Signup: Password confirmation must match Password."
    case E010 = "Error E010 - Login: User and/or password is/are empty."
    case E011 = "Success E011 - Login: User has been access to the system."
    case E012 = "Success E012 - Login: User has been create in the system."
    
}


