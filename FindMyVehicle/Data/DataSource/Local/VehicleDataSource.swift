//
//  DataSource.swift
//  FindMyVehicle
//
//  Created by ndyyy on 01/01/24.
//


import Foundation
import CoreData


class VehicleDataSource: VehicleDataSourceProtocol {
    private var coreDataManager = CoreDataManager.shared
    
    func fetchAllVehicle() async -> Result<[VehicleModel], Error> {
        let vehicle = NSFetchRequest<Vehicle>(entityName: "Vehicle")
        
        do {
            let results = try coreDataManager.context.fetch(vehicle)
            return .success(results.map { VehicleModel.toModel($0) })
        } catch {
            print("Error: \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
    func addVehicle(vehicle: VehicleModel) async {
        let _ = vehicle.toEntity(context: coreDataManager.context)
        coreDataManager.saveContext()
    }
    
}
