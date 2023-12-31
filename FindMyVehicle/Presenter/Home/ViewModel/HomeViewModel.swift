//
//  HomeViewModel.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/12/23.
//

import Foundation
import CoreLocation
import Combine

protocol CoreDataFunctionProtocol {
    func addVehicle()
    func fetchVehicles()
    func fetchActiveVehicles()
    func deleteAllVehicles()
}

class HomeViewModel: ObservableObject {
    
    @Published var coreDataManager: CoreDataManager = CoreDataManager.shared
    @Published var coreLocationManager: CoreLocationManager = CoreLocationManager.shared
    @Published var activeTab: Tab = .vehicle
    
    @Published var vehicles: [VehicleModel] = []
    @Published var activeVehicle: [VehicleModel] = []
    @Published var isAddVechileActive: Bool = false
    @Published var vehicleName: String = ""
    
    @Published var sheetHeight: CGFloat = 110
    @Published var isDetailViewClicked: Bool = false //must be move to detailvm (?)
    
}

extension HomeViewModel: CoreDataFunctionProtocol {
    func addVehicle() {
        isAddVechileActive.toggle()
        let vehicle = VehicleModel(name: vehicleName, latitude: coreLocationManager.location.latitude, longitude: coreLocationManager.location.longitude, isActive: true, date: Date())
        coreDataManager.addVehicleLocation(vehicle: vehicle)
        vehicleName = ""
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

//MARK: MapKit add pin
extension HomeViewModel {
    func addPin() {
        for x in vehicles.indices {
            NotificationCenter.default.post(name: Notification.Name("AddPin"), object: nil, userInfo: ["longitude": vehicles[x].longitude, "latitude": vehicles[x].latitude, "name": vehicles[x].name])
        }
    }
}
