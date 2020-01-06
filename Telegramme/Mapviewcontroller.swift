//
//  Mapviewcontroller.swift
//  Telegramme
//
//  Created by MAD2_P02 on 6/1/20.
//  Copyright © 2020 MAD2_P02. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class Mapviewcontroller : UIViewController{
    
    @IBOutlet weak var map: MKMapView!
    let locationDelegate = LocationDelegate()
    var latestLocation: CLLocation? = nil
    let regionRadius: CLLocationDistance = 250
    let annotation = MKPointAnnotation()

    
    let locationManager : CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.startUpdatingLocation()
        $0.startUpdatingHeading()
        return $0
    }(CLLocationManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = locationDelegate
        
        locationDelegate.locationCallback = { location in self.latestLocation = location
            let lat = String(format: "Lat: %3.8f", location.coordinate.latitude)
            let long = String(format: "Long: %3.8f", location.coordinate.longitude)
            print("\(lat), \(long)")
            
            self.centerMapOnLocation(location: location)
        }
    }
        
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    
}
