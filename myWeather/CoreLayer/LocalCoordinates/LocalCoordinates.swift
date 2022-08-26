//
//  LocalCoordinates.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import Foundation
import CoreLocation

class LocalCoordinates: NSObject {

    static var coordinates = CLLocationCoordinate2D()
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        startLocationManager()
    }
    
    
    private func startLocationManager(){
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
}

extension LocalCoordinates: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            LocalCoordinates.coordinates = lastLocation.coordinate
        }
    }
}
