//
//  CoreLocationManager.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import Foundation
import CoreLocation


class CoreLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var location = CLLocationCoordinate2D()
    static let shared = CoreLocationManager()
    
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            location = $0.coordinate
        }
    }
}
