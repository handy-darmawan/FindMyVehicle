//
//  VehicleDataSourceProtocol.swift
//  FindMyVehicle
//
//  Created by ndyyy on 25/12/23.
//

import Foundation

protocol VehicleDataSourceProtocol {
    func addVehicle(vehicle: VehicleModel) async
    func fetchAllVehicle() async -> Result<[VehicleModel], Error>
}
