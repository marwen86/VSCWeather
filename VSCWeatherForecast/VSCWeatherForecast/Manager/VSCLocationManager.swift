//
//  VSCLocationManager.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 26/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func locationDidUpdate(_ service: VSCLocationManager, location: CLLocation)
}

class VSCLocationManager: NSObject {
    var delegate: LocationServiceDelegate?
    
    fileprivate let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension VSCLocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            delegate?.locationDidUpdate(self, location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error finding location: \(error.localizedDescription)")
    }
}

