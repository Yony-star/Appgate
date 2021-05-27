//
//  AuthError.swift
//  
//
//  Created by Yony Gonzalez Vargas on 24/05/21.
//

import Foundation

/*
Abstract:
Errors that can be generated as a result of attempting user Auth.
*/
import Security
import Foundation
/// An error we can throw when something goes wrong.
public enum AuthError: Error
{
    case success
    case fail
    case unknown
}
