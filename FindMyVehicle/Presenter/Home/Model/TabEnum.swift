//
//  TabEnum.swift
//  FindMyVehicle
//
//  Created by ndyyy on 26/12/23.
//

import Foundation

enum Tab: String, CaseIterable {
    case vehicle = "car.fill"
    case history = "clock.arrow.circlepath"
    
    var title: String {
        switch self {
        case .vehicle:
            return "Vehicle"
        case .history:
            return "History"
        }
    }
}


