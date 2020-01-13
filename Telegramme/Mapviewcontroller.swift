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

class customPin: NSObject,MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate:CLLocationCoordinate2D,title:String,subtitle:String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class Mapviewcontroller : UIViewController{
    
    @IBOutlet weak var map: MKMapView!
    let locationDelegate = LocationDelegate()
    let regionRadius: CLLocationDistance = 250
    var latestLocation :CLLocation? = nil
    
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
            
            self.centerMapOnLocation(location: location)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location.coordinate
            annotation.title = "Ngee Ann Polytechnic"
            annotation.subtitle = "School of ICT"
            self.map.addAnnotation(annotation)
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString("535 Clementi Road Singapore 599489", completionHandler: {p,e in
                
                let lat = String(format: "Lat: %3.12f", p![0].location!.coordinate.latitude)
                let long = String(format: "Long: %3.12f", p![0].location!.coordinate.longitude)
                
                print("\(lat),\(long)")
            })
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
}
