//
//  EventTime.swift
//  Appgate
//
//  Created by Yony Gonzalez Vargas on 24/05/21.
//

import Foundation

public struct EventTime : Codable
{
    public  let time: String
    public  let lat : Double
    public  let lng : Double
    public  let timezoneId : String
    public  let countryCode : String
}
