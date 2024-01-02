//
//  DetailView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 31/12/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct DetailSheetView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(homeVM.currentVehicle.name)
                Text(homeVM.currentVehicle.getDistance(from: homeVM.coreLocationManager.location))
                Button {
                    //start geofence
                    homeVM.coreLocationManager.startGeofenceMonitoring(for: homeVM.currentVehicle)
                } label: {
                    Text("Track")
                }
                .buttonStyle(.borderedProminent)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        homeVM.isDetailViewClicked.toggle()
                        homeVM.coreLocationManager.stopGeofenceMonitor(for: homeVM.currentVehicle)
                        NotificationCenter.default.post(name: NSNotification.Name("DeleteRoute"), object: nil)
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                    })
                }
            }
        }
    }
}
