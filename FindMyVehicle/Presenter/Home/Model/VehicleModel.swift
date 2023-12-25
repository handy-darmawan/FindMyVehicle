//
//  VehicleModel.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/12/23.
//

import Foundation

struct VehicleModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
}

//dd
//map to entity
extension VehicleModel {
    func toEntity() -> Vehicle {
        let vehicle = Vehicle()
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
