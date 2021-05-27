//
//  LogReportTableViewCell.swift
//  Appgate
//
//  Created by Yony Gonzalez Vargas on 26/05/21.
//

import UIKit

class LogReportTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var labelEventCell: UILabel!
    @IBOutlet weak var labelUserCell: UILabel!
    @IBOutlet weak var labelLocationCell: UILabel!
    @IBOutlet weak var labelTimeZoneCell: UILabel!


    
    override func awakeFromNib() {
        super.awakeFromNib()
           // Initialization code
        }
     
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
 
       // Configure the view for the selected state
    }
    
}
