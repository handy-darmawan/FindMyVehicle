//
//  IBeaconReader.swift
//  FindVehicle
//
//  Created by ndyyy on 20/05/23.
//

import CoreLocation
import SwiftUI

class IBeaconDetector: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager = CLLocationManager()
    
    //MARK: IBeacon
    @Published var lastDistance = CLProximity.unknown
    @Published var accuracy: CLLocationAccuracy = 0.0
    @Published var item: IBeaconModel = IBeaconModel(uuid: UUID(uuidString: "C9616ADC-E4F3-4DC5-892E-86174E0CB0E6")!, name: "", major: 222, minor: 156)

    //MARK: Location
    @Published var lastLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) && CLLocationManager.isRangingAvailable() {
                startIBeacon(item: item)
            }
        }
    }
    
    func startIBeacon(item: IBeaconModel) {
        let uuid = item.uuid
        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: CLBeaconMajorValue(item.major), minor: CLBeaconMinorValue(item.minor))
        let beaconRange = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: item.name)
        
        locationManager.startMonitoring(for: beaconRange)
        locationManager.startRangingBeacons(satisfying: constraint)
    }
    
    func stopIBeacon(item: IBeaconModel) {
        let uuid = item.uuid
        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: CLBeaconMajorValue(item.major), minor: CLBeaconMinorValue(item.minor))
        let beaconRange = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: item.name)
        
        locationManager.stopMonitoring(for: beaconRange)
        locationManager.stopRangingBeacons(satisfying: constraint)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        DispatchQueue.main.async {
            if let beacon = beacons.first {
                self.lastDistance = beacon.proximity
                self.accuracy = beacon.accuracy
            }
            else {
                self.lastDistance = .unknown
                self.accuracy = 0.0
            }
            
        }
        
        print("\n")
        print("Updated LastDistance \(self.lastDistance)")
        print("Updated Accuracy \(self.accuracy)")
        print(item.uuid.uuidString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastLocation = locationManager.location!.coordinate
//        print(lastLocation.longitude)
//        print(lastLocation.latitude)
    }
    
}
