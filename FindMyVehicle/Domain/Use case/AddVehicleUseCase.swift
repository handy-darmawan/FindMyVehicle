//
//  AddVehicleUseCase.swift
//  FindMyVehicle
//
//  Created by ndyyy on 01/01/24.
//

import Foundation

class AddVehicleUseCase {
    private let repository = CoreDataRepository.shared
    
    func execute(vehicle: VehicleModel) async {
        await repository.dataSource.addVehicle(vehicle: vehicle)
    }
}
