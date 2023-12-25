//
//  HomeViewModel.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/12/23.
//

import Foundation
import CoreLocation


class HomeViewModel: ObservableObject {
    @Published var coreDataManager: CoreDataManager = CoreDataManager.shared
    @Published var coreLocationManager: CoreLocationManager = CoreLocationManager.shared
    
    func saveLocation(with name: String?, location: CLLocationCoordinate2D) {
        coreDataManager.addVehicleLocation(for: name, location: location)
    }
}
