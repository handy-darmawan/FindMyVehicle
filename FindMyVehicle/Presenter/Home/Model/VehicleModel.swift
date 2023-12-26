//
//  VehicleModel.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/12/23.
//

import Foundation
import CoreData

struct VehicleModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
}

//map to entity
extension VehicleModel {
    func toEntity(context: NSManagedObjectContext) -> Vehicle {
        let vehicle = Vehicle(context: context)
        vehicle.id = id
        vehicle.name = name
        vehicle.latitude = latitude
        vehicle.longitude = longitude
        
        return vehicle
    }
    
    static func toModel(_ vehicle: Vehicle) -> VehicleModel {
        return VehicleModel(
            id: vehicle.id!,
            name: vehicle.name ?? "",
            latitude: vehicle.latitude,
            longitude: vehicle.longitude
        )
    }
}

extension VehicleModel {
    static var mockData: [VehicleModel] {
        return [
            VehicleModel(name: "Car", latitude: 0, longitude: 0),
            VehicleModel(name: "Motorcycle", latitude: 0, longitude: 0),
            VehicleModel(name: "Bicycle", latitude: 0, longitude: 0),
            VehicleModel(name: "Scooter", latitude: 0, longitude: 0)
        ]
    }
}
