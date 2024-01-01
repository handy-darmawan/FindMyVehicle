//
//  AddVehicleUseCase.swift
//  FindMyVehicle
//
//  Created by ndyyy on 01/01/24.
//

import Foundation

class GetAllVehicleUseCase {
    private let repository = CoreDataRepository.shared
    
    func execute() async throws -> [VehicleModel] {
        switch await repository.dataSource.fetchAllVehicle() {
        case .success(let vehicles):
            return vehicles
        case .failure(let failure):
            throw failure
        }
    }
}
