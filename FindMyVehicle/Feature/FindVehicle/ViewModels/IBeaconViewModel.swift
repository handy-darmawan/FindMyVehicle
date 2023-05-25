//
//  IBeaconViewModel.swift
//  FindVehicle
//
//  Created by ndyyy on 23/05/23.
//

import Foundation

class IBeaconViewModel: ObservableObject, Identifiable {
    @Published var newIBeacon = IBeaconModel(uuid: UUID(), name: "", major: 0, minor: 0)
    
    @Published var uuid: String = ""
    @Published var major: String = ""
    @Published var minor: String = ""
    @Published var name: String = ""
    
}
