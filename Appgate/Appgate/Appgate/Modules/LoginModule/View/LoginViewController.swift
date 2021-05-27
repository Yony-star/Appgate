//
//  LoginViewController.swift
//  Appgate
//
//  Created by Yony Gonzalez Vargas on 24/05/21.
//

import UIKit
import Foundation
import AppgateLibrary
import CoreLocation
import CoreData


internal class LoginViewController: UIViewController, CLLocationManagerDelegate
{
    ///
    @IBOutlet  weak var textfieldAccount: UITextField!
    ///
    @IBOutlet  weak var textfieldPassword: UITextField!
    ///
    @IBOutlet  weak var labelMessage: ResultLabel!
    ///
    @IBOutlet  weak var buttonLogin: UIButton!
    ///
    @IBOutlet  weak var buttonDelete: UIButton!
    ///
    @IBOutlet  weak var buttonSave: UIButton!
    
    private var appgateSecurity : AppgateLibrary!

    private var locationManager: CLLocationManager?
    
    private var latitude: String = ""
    
    private var longitude: String = ""
    
    private var context : NSManagedObjectContext?
    
    private var logger : Logger?
    
    

    
    //
    // MARK: - Life Cycle
    //
    

    /**
 
    */
    override internal func viewDidLoad()
    {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        self.appgateSecurity = AppgateLibrary()
        self.logger = Logger.sharedInstance
        self.logger?.context = appDelegate?.persistentContainer.viewContext
        self.locationManager?.requestLocation()
        
        //UITEST
        self.labelMessage.accessibilityIdentifier = "label-message"
        self.labelMessage.isAccessibilityElement = true
        self.textfieldAccount.accessibilityIdentifier = "text-field-account"
        self.textfieldAccount.isAccessibilityElement = true
        self.textfieldPassword.accessibilityIdentifier = "text-field-password"
        self.textfieldPassword.isAccessibilityElement = true
        self.buttonLogin.accessibilityIdentifier = "button-login"
        self.buttonLogin.isAccessibilityElement = true
        
    }

    
    //
    // MARK: - Actions
    //
    
    /**
 
    */
    @IBAction  func handleLoginButtonTap(sender: UIButton) -> Void
    {
        let account = self.textfieldAccount.text ?? ""
        let password = self.textfieldPassword.text ?? ""
        
        updateMessage(message: "")
        
        securityCall(loginAction: LoginAction.Login, account: account, password1: password, password2:password)
    }
    
    /**
 
    */
    @IBAction  func handleSaveButtonTap(sender: UIButton) -> Void
    {
        let account = self.textfieldAccount.text ?? ""
        let password = self.textfieldPassword.text ?? ""
        
        // ONLY VALIDATE CREDETIAL ON SING UP PROCESS
        
        if !account.isValidEmail{
            updateMessage(message: "Please enter a valid email address.")
            return
        }
        
        if !password.isValidPassword{
            updateMessage(message: "The password must be at least 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character")
            return
        }
        
        updateMessage(message: "")
        
        securityCall(loginAction: LoginAction.Signup, account: account, password1: password, password2:password)
    }
    
    /**
 
    */
    func securityCall(loginAction: LoginAction, account: String, password1: String, password2:String){
        
        self.locationManager?.requestLocation()
        
        if ( self.latitude.isEmpty || self.longitude.isEmpty){
            alertGPS()
            return
        }
        
        let securityEventResult : Event

        switch loginAction {
        case .Login:
            securityEventResult = self.appgateSecurity.AuthGetCredetials(login: account , password: password1)
        case .Signup:
            securityEventResult = self.appgateSecurity.AuthSaveCredetials(login: account , password1: password1 , password2: password2 )
        }
        
        
        
        self.logger?.createEventLog(login: account, success: securityEventResult.eventCode.rawValue, latitude: self.latitude, longitude: self.longitude)
        
        if securityEventResult.eventCode == .E011{
            let next = self.storyboard?.instantiateViewController(withIdentifier: "LogReportViewController") as? LogReportViewController
            self.present(next!, animated: true, completion: nil)
        }
        
        updateMessage(message:securityEventResult.message)
        
    }
    
    
    
    func updateMessage( message:  String){
        self.labelMessage.text = message
        //FIX CHANGE IDENTIFIER
        self.labelMessage.accessibilityIdentifier = "label-message"
        self.labelMessage.isAccessibilityElement = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedWhenInUse:
                //manager.startUpdatingLocation()
                break
            case .authorizedAlways:
                //manager.startUpdatingLocation()
                break
            case .denied:
                manager.requestWhenInUseAuthorization()
                break
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
               break
            default:
                break
            }
    }

    

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            latitude = String(location.coordinate.latitude)
            longitude = String(location.coordinate.longitude)
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        //alertGPS()
    }
    
    func alertGPS(){
        let alert = UIAlertController(title: "Appgate Alert", message: "This application does not work if you do not have active GPS and do not allow permission to access the location. Remember that the simulator must simulate GPS. In Xcode, go to Debug Menu -> Simulate Location -> AppgateTrip", preferredStyle: .alert)
        
       

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

extension String {
    var isValidPassword: Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
}

class ResultLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        accessibilityValue = text
        accessibilityIdentifier = "label-message"
    }

    override var text: String? {
        didSet {
            accessibilityValue = text
            accessibilityIdentifier = "label-message"
        }
    }
}
