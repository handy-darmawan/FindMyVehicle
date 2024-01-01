//
//  CoreDataRepository.swift
//  FindMyVehicle
//
//  Created by ndyyy on 01/01/24.
//

import Foundation

class CoreDataRepository {
    static let shared = CoreDataRepository()
    let dataSource = VehicleDataSource()
    
    private init() {}
}
