//
//  Logger.swift
//  Appgate
//
//  Created by Yony Gonzalez Vargas on 23/05/21.
//

import UIKit
import CoreData
public class Logger {
    
    //Singleton Pattern
    public static let sharedInstance = Logger()
    
    var lastEventLog : EventLog
    var context : NSManagedObjectContext!
    //var log: NSFetchedResultsController!
    public var EventLogList: [EventLog] = []
    
    init(){
        self.lastEventLog = EventLog(timeStamp: "" , login: "", event: "", IPAddress: "", latitude: "", longitude: "", timezoneId: "", countryCode : "")
    }
    
    public func createEventLog(login : String , success: String, latitude: String, longitude: String ) {
        
        TimeServiceAPI.shared.fetchTime(lat: latitude, lng: longitude) { (result: Result<EventTime, TimeServiceAPI.APIServiceError>) in
            switch result {
                case .success(let eventTime):
                    
                    self.lastEventLog = EventLog(timeStamp: eventTime.time, login: login, event: success, IPAddress: "", latitude: latitude, longitude: longitude, timezoneId: eventTime.timezoneId, countryCode : eventTime.countryCode)
                    
                    print(self.lastEventLog)
                    
                    self.saveEventLog(eventLog: self.lastEventLog)
                    
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
    func saveEventLog(eventLog: EventLog){
        let entity = NSEntityDescription.entity(forEntityName: "Log", in: self.context)!
        let newLog = NSManagedObject(entity: entity, insertInto: self.context)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: eventLog.timeStamp) {
            newLog.setValue(date, forKey: "timestamp")
        }
        
        
        
        newLog.setValue(eventLog.login, forKey: "user")
        newLog.setValue(eventLog.event, forKey: "event")
        newLog.setValue(eventLog.IPAddress, forKey: "ipAddress")
        newLog.setValue(Double(eventLog.latitude), forKey: "latitude")
        newLog.setValue(Double(eventLog.longitude), forKey: "longitude")
        newLog.setValue(eventLog.timezoneId, forKey: "timezoneId")
        newLog.setValue(eventLog.countryCode, forKey: "countryCode")
        
        do {
            try self.context.save()
          } catch {
           print("Failed saving log")
        }
    }
    
    func loadEventLog(){
        
        EventLogList = []
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Log")
                //request.predicate = NSPredicate(format: "age = %@", "12")
                request.returnsObjectsAsFaults = false
                do {
                    let result = try self.context.fetch(request)
                    
                    for data in result as! [NSManagedObject] {
                        
                        var event = EventLog(timeStamp: "", login: "", event: "", IPAddress: "", latitude: "", longitude: "", timezoneId: "", countryCode: "")

                        event = EventLog(
                            timeStamp: unwrapping(unwrappingField: data.value(forKey: "timestamp")),
                            login : unwrapping(unwrappingField: data.value(forKey: "user")),
                            event: unwrapping(unwrappingField: data.value(forKey: "event")),
                            IPAddress: unwrapping(unwrappingField: data.value(forKey: "ipAddress")),
                            latitude: unwrapping(unwrappingField: data.value(forKey: "latitude")),
                            longitude: unwrapping(unwrappingField: data.value(forKey: "longitude")),
                            timezoneId: unwrapping(unwrappingField: data.value(forKey: "timezoneId")),
                            countryCode: unwrapping(unwrappingField: data.value(forKey: "countryCode"))
                        )
                        
                        EventLogList.append(event)

                  }
                    
                } catch {
                    
                    print("Failed reading log")
                }
    }
    
    func unwrapping(unwrappingField: Any?) -> String{
        if let unwrappedName = unwrappingField  {
            return "\(unwrappedName)"
        } else {
            return ""
        }
    }
    
    
    
    func toDate(eventDate : String) -> Date {
        var dateOut = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: eventDate) {
            dateOut =  date
        }
        return dateOut
    }

}


