//
//  HomeViewModel.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/12/23.
//

import Foundation
import CoreLocation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var coreLocationManager: CoreLocationManager = CoreLocationManager.shared
    @Published var activeTab: Tab = .vehicle
    
    @Published var historyVM = HistoryViewModel()
    
    @Published var vehicles: [VehicleModel] = []
    @Published var activeVehicle: [VehicleModel] = []
    @Published var isAddVechileActive: Bool = false
    @Published var vehicleName: String = ""
    
    @Published var sheetHeight: CGFloat = 110
    @Published var isDetailViewClicked: Bool = false
    @Published var currentVehicle: VehicleModel!
    
    var getAllVehicleUseCase = GetAllVehicleUseCase()
    var addVehicleUseCase = AddVehicleUseCase()
}

extension HomeViewModel {
    private func fetchVehicles() async {
        do {
            vehicles = try await getAllVehicleUseCase.execute()
        }
        catch {
            print("Error when fetch vehicles")
            vehicles = []
        }
    }
    
    func addVehicle() async {
        isAddVechileActive.toggle()
        let vehicle = VehicleModel(name: vehicleName, latitude: coreLocationManager.location.latitude, longitude: coreLocationManager.location.longitude, isActive: true, date: Date())
        await addVehicleUseCase.execute(vehicle: vehicle)
        vehicleName = ""
    }
    
    func fetchActiveVehicles() async {
        await fetchVehicles()
        activeVehicle = vehicles.filter({ return $0.isActive == true })
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
