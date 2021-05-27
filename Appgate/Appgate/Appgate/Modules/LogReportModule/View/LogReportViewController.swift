//
//  LogReportViewController.swift
//  Appgate
//
//  Created by Yony Gonzalez Vargas on 25/05/21.
//

import Foundation
import UIKit

class LogReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    public var logger = Logger.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        logger.loadEventLog()
        setupTableView()

    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logger.EventLogList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! LogReportTableViewCell
        
        cell.labelCell.text = "TIME: " + (self.logger.EventLogList[indexPath.row].timeStamp).replacingOccurrences(of:  " +0000", with: "")
        
        cell.labelEventCell.text = "EVENT: " + (self.logger.EventLogList[indexPath.row].event)
        
        cell.labelUserCell.text = "USER: " + (self.logger.EventLogList[indexPath.row].login)
        
        cell.labelLocationCell.text = "LOCATION: Latitude " + (self.logger.EventLogList[indexPath.row].latitude) + ", Longitude " + (self.logger.EventLogList[indexPath.row].longitude)
        
        cell.labelTimeZoneCell.text = "TIME ZONE: " + (self.logger.EventLogList[indexPath.row].timezoneId) + ", " + (self.logger.EventLogList[indexPath.row].countryCode)
        
        return cell
    }
    
    

}
