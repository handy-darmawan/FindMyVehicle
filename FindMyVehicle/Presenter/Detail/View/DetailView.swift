//
//  DetailView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 31/12/23.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    var vehicle: VehicleModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(vehicle.name)
                Text(vehicle.getDistance(from: homeVM.coreLocationManager.location))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        homeVM.isDetailViewClicked.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                    })
                }
            }
        }
    }
}
