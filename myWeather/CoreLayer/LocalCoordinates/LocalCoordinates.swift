//
//  LocalCoordinates.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import Foundation
import CoreLocation

class LocalCoordinates: NSObject {
    
    private let locationManager = CLLocationManager()
    public var coordinates: CLLocationCoordinate2D?
    public var goToLocation: ((CLLocationCoordinate2D)->())
    
    init(goToLocation: @escaping (CLLocationCoordinate2D)->()) {
        self.goToLocation = goToLocation
        super.init()
        startLocationManager()
    }
    
    
    private func startLocationManager(){
        self.locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {return}
            if CLLocationManager.locationServicesEnabled() {
                    self.locationManager.delegate = self
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                    self.locationManager.pausesLocationUpdatesAutomatically = true
            }
        }
    }
}

extension LocalCoordinates: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            coordinates = lastLocation.coordinate
            self.locationManager.stopUpdatingLocation()
            goToLocation(lastLocation.coordinate)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch self.locationManager.authorizationStatus {
            
        case .notDetermined:
            print("notDetermined")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse, .restricted:
            self.locationManager.startUpdatingLocation()
        @unknown default:
            print("default")
        }
    }
    
    
}


