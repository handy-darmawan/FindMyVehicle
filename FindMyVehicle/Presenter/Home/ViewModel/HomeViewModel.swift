//
//  HomeViewModel.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/12/23.
//

import Foundation
import CoreLocation


class HomeViewModel: ObservableObject {
    @Published var coreDataManager: CoreDataManager = CoreDataManager.shared
    @Published var coreLocationManager: CoreLocationManager = CoreLocationManager.shared
    @Published var activeTab: Tab = .vehicle
    
    @Published var vehicles: [VehicleModel] = []
    
    func addVehicle(with name: String?, location: CLLocationCoordinate2D) {
        let vehicle = VehicleModel(name: name ?? "", latitude: location.latitude, longitude: location.longitude)
        coreDataManager.addVehicleLocation(vehicle: vehicle)
        
        //refresh vehicles variable by fetchVehicles
        fetchVehicles()
    }
    
    func fetchVehicles() {
        vehicles = coreDataManager.fetchAllVehicleLocation()
    }    
}
