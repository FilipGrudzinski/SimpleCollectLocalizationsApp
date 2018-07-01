//
//  ViewController.swift
//  SimpleCollectLocalizationsApp
//
//  Created by Filip on 29.06.2018.
//  Copyright © 2018 Filip. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        //let latitude = userLocation.coordinate.latitude
        //let longitude = userLocation.coordinate.latitude
        //let course = userLocation.course
        //let speed = userLocation.speed
        //let atltitude = userLocation.altitude
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation) {(placemarks, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let placemark = placemarks?[0] {
                    
                    var country = ""
                    var postalCode = ""
                    var subAdministrativeArea = ""
                    var subLocality = ""
                    var thoroughFare = ""
                    var subThoroughFare = ""
                    var administrativeArea = ""
                    
                    if placemark.country != nil { country = placemark.country! }
                    
                    if placemark.postalCode != nil { postalCode = placemark.postalCode! }
                    
                    if placemark.subAdministrativeArea != nil { subAdministrativeArea = placemark.subAdministrativeArea! }
                    
                    if placemark.subLocality != nil { subLocality = placemark.subLocality! }
                    
                    if placemark.thoroughfare != nil { thoroughFare = placemark.thoroughfare! }
                    
                    if placemark.subThoroughfare != nil { subThoroughFare = placemark.subThoroughfare! }
                    
                    if placemark.administrativeArea != nil { administrativeArea = placemark.administrativeArea! }
                    
                    self.addressLabel.text = (subThoroughFare + " " + thoroughFare + "\n" + subLocality + "\n" + subAdministrativeArea + "\n"
                        +  administrativeArea + " " + postalCode + "\n" + country )
                    
                    self.longitudeLabel.text = String(userLocation.coordinate.longitude)
                    self.latitudeLabel.text = String(userLocation.coordinate.latitude)
                    self.speedLabel.text = String(userLocation.speed)
                    self.courseLabel.text = String(userLocation.course)
                    self.altitudeLabel.text = String(userLocation.altitude)
                    
                }
                
                
            }
            
            
        }
        
    }

}

