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
    @Published var activeVehicle: [VehicleModel] = []
    @Published var isAddVechileActive: Bool = false
    
    func addVehicle(with name: String?, location: CLLocationCoordinate2D) {
        let vehicle = VehicleModel(name: name ?? "", latitude: location.latitude, longitude: location.longitude, isActive: true, date: Date())
        coreDataManager.addVehicleLocation(vehicle: vehicle)
    }
    
    func fetchVehicles() {
        vehicles = coreDataManager.fetchAllVehicleLocation()
    }
    
    func fetchActiveVehicles() {
        fetchVehicles()
        activeVehicle = vehicles.filter({ return $0.isActive == true })
    }
    
    func deleteAllVehicles() {
        coreDataManager.deleteBatch()
    }
}
