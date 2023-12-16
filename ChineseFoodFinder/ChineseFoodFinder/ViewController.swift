/*
 Patrick Myers, Chinese Food Finder, PG6
 
 The purpose of this app is to take in coordinates from the user and append them to a URL.
 The URL is passed to a second view where it is opened in a wkView. This will pull up Google
 maps at the location the user specifies. It will also highlight all chinese food locations
 within an appoximate one mile radius.
 
 */

import UIKit
import CoreLocation // package used to get location of device

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // Initializations
    var svc:SecondViewController?
    var latitude:String?
    var longitude:String?
    var sumbit:UIButton?
    @IBOutlet weak var latTF: UITextField!
    @IBOutlet weak var longTF: UITextField!
    var address:String?
    var base:String?
    var locationManager = CLLocationManager ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Gets the GPS coordinates of the device
    func locationManager (_ manager:CLLocationManager,didUpdateLocations locations:[CLLocation]) {
        let loc = locations[0]
        let coord = loc.coordinate
        longitude = String(coord.longitude)
        latitude = String(coord.latitude)
    }

    
    // This method will run when the submit button is clicked in the viewController
    @IBAction func clicked(_ sender: Any) {
        
        // Get the long and lat from the user via the textFields
        latitude = latTF!.text
        longitude = longTF!.text
        
        // Check to make sure lat is within the acceptable range
        // If not, grab the gps location of the device and use
        // that instead
        if Double(latitude!)! < -90.0 || Double(latitude!)! > 90.0 {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        svc = tabBarController!.viewControllers![1] as? SecondViewController
        _ = svc!.view
        
        // Build the URL from the user specified coordinates
        let sub = latitude!+","+longitude!
        let address = "http://maps.google.co.uk/maps?f=q&ll=" + sub + "&q=chinese+restaurant&z=15"
        
        // Load the google maps address into the webview in the other viewController
        let url = URL (string:address)
        let requestObj = URLRequest (url:url!)
        svc!.wv!.load (requestObj)
        
        // Open the view containing the map
        tabBarController!.selectedIndex = 1
        
    }
}
