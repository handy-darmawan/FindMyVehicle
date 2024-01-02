//
//  HistoryViewModel.swift
//  FindMyVehicle
//
//  Created by ndyyy on 01/01/24.
//

import Foundation

@MainActor
class HistoryViewModel: ObservableObject {
    
    @Published var vehicles: [VehicleModel] = []
    
    var getAllVehicleUseCase = GetAllVehicleUseCase()
    
    func fetchVehicles() async {
        do {
            vehicles = try await getAllVehicleUseCase.execute()
        }
        catch {
            print("Error when fetch vehicles")
            vehicles = []
        }
    }
}
