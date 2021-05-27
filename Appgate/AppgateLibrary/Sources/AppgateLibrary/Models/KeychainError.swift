//
//  KeychainError.swift
//  
//
//  Created by Yony Gonzalez Vargas on 23/05/21.
//
/*
Abstract:
Errors that can be generated as a result of attempting to store keys.
*/
import Security
import Foundation
/// An error we can throw when something goes wrong.
public enum KeychainError: Error
{
    case passwordNotFound
    case malformedData
    case unknown(status: OSStatus)
}
