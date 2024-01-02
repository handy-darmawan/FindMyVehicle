//
//  CoreLocationManager.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import Foundation
import CoreLocation
import UIKit

//geofence

class CoreLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var location = CLLocationCoordinate2D()
//    @Published var location = CLLocationCoordinate2D(latitude: -6.1356004, longitude: 106.7824644)
//    @Published var userHeading: CLLocationDirection?
    
    static let shared = CoreLocationManager()
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            location = $0.coordinate
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("User didn't choose yet")
        case .restricted:
            print("Parental control")
        case .denied:
            print("User denied")
        case .authorizedAlways:
            print("User allowed always")
        case .authorizedWhenInUse:
            print("User allowed when in use")
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        @unknown default:
            print("default")
        }
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard region is CLCircularRegion else { return }
        print("did enter region")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        guard region is CLCircularRegion else { return }
        print("did exit region")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if newHeading.headingAccuracy < 0 { return }
        let heading = (newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading
        NotificationCenter.default.post(name: NSNotification.Name("Heading"), object: nil, userInfo: ["heading": heading])
    }
}


//MARK: - Geofence
extension CoreLocationManager {
    
    private func setupGeofence() {
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
            print("Geofencing is not supported on this device")
            return
        }
    }
    
    func startGeofenceMonitoring(for vehicle: VehicleModel) {
        setupGeofence()
        let geofenceRegion = CLCircularRegion(
            center: CLLocationCoordinate2D(
                latitude: vehicle.latitude,
                longitude: vehicle.longitude
            ),
            radius: 1,
            identifier: vehicle.name
        )
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        locationManager.startMonitoring(for: geofenceRegion)
        print("geofence active")
    }
    
    func stopGeofenceMonitor(for vehicle: VehicleModel) {
        setupGeofence()
        let geofenceRegion = CLCircularRegion(
            center: CLLocationCoordinate2D(
                latitude: vehicle.latitude,
                longitude: vehicle.longitude
            ),
            radius: 1,
            identifier: vehicle.name
        )
        
        locationManager.stopMonitoring(for: geofenceRegion)
        print("geofence deactivate")
    }
    
    
}
