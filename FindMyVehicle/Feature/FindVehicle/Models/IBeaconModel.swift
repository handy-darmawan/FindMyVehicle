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
}
