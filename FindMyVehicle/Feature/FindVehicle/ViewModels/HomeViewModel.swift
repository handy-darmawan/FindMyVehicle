//
//  HomeViewModel.swift
//  FindVehicle
//
//  Created by ndyyy on 22/05/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {

    @Published var detector = IBeaconDetector()
    
    @Published var iBeaconVM = IBeaconViewModel()
    @Published var lastItem = IBeaconModel(uuid: UUID(uuidString: "C9616ADC-E4F3-4DC5-892E-86174E0CB0E6")!, name: "mCar", major: 222, minor: 156)
    
    @Published var isAddButtonClicked: Bool = false
    var gridColumn = [GridItem(), GridItem()]
    
    @Published var ibeaconData: [IBeaconModel] = [
        IBeaconModel(uuid: UUID(uuidString: "CB10023F-A318-3394-4199-A8730C7C1AEC")!, name: "cMotorcycle", major: 222, minor: 156),
        IBeaconModel(uuid: UUID(uuidString: "C9616ADC-E4F3-4DC5-892E-86174E0CB0E6")!, name: "mCar", major: 222, minor: 156)
    ]

    func addIBeacon() {
        if !iBeaconVM.uuid.isEmpty {
            iBeaconVM.newIBeacon.id = UUID(uuidString: iBeaconVM.uuid)!
            iBeaconVM.newIBeacon.major = Int(iBeaconVM.major)!
            iBeaconVM.newIBeacon.minor = Int(iBeaconVM.minor)!
            iBeaconVM.newIBeacon.name = iBeaconVM.name
            
            ibeaconData.append(iBeaconVM.newIBeacon)
            
            print("success")
        }
        else {
            print("insertion failed")
        }
    }
    
    
}
