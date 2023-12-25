//
//  CoreDataProtocol.swift
//  FindMyVehicle
//
//  Created by ndyyy on 25/12/23.
//

import Foundation
import CoreLocation

protocol CoreDataProtocol {
    func addVehicleLocation(vehicle: VehicleModel)
    func fetchAllVehicleLocation() -> [VehicleModel]
    func deleteVehicle(for id: UUID)
}
