//
//  LoginAction.swift
//  Appgate
//
//  Created by Yony Gonzalez Vargas on 25/05/21.
//
/*
Abstract:
Errors that can be generated as a result of attempting to store keys.
*/
import Security
import Foundation
/// An error we can throw when something goes wrong.
public enum LoginAction
{
    case Login
    case Signup
}

