//
//  VehicleModel.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/12/23.
//

import Foundation
import CoreData
import CoreLocation

struct VehicleModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    var isActive: Bool
    var date: Date
}

//MARK: Mapper function
extension VehicleModel {
    func toEntity(context: NSManagedObjectContext) -> Vehicle {
        let vehicle = Vehicle(context: context)
        vehicle.id = id
        vehicle.name = name
        vehicle.latitude = latitude
        vehicle.longitude = longitude
        vehicle.isActive = true
        vehicle.date = Date()
        
        return vehicle
    }
    
    static func toModel(_ vehicle: Vehicle) -> VehicleModel {
        return VehicleModel(
            id: vehicle.id!,
            name: vehicle.name ?? "",
            latitude: vehicle.latitude,
            longitude: vehicle.longitude,
            isActive: vehicle.isActive,
            date: vehicle.date!
        )
    }
}


//MARK: Methods
extension VehicleModel {
    func getDistance(from current: CLLocationCoordinate2D) -> String {
        let vehicleLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentLocation = CLLocation(latitude: current.latitude, longitude: current.longitude)
        
        let distance = vehicleLocation.distance(from: currentLocation)
        return String(format: "%.2f", distance)
    }
}
