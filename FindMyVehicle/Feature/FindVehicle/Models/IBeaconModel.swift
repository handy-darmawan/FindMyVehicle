//
//  IBeaconModel.swift
//  FindVehicle
//
//  Created by ndyyy on 22/05/23.
//

import Foundation

struct IBeaconModel: Identifiable, Equatable {
    var id = UUID()
    var uuid: UUID
    var name: String
    var major: Int
    var minor: Int
    
    init(uuid: UUID, name: String, major: Int, minor: Int) {
        self.id = UUID()
        self.uuid = uuid
        self.name = name
        self.major = major
        self.minor = minor
    }
}
