//
//  MapKitView+UIRepresentable.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/12/23.
//

import SwiftUI
import MapKit

struct MapKitViewRepresentable: UIViewRepresentable {
    @EnvironmentObject var homeVM: HomeViewModel
    
    func makeUIView(context: Context) -> MapKitView {
        let mapKitView = MapKitView()
        return mapKitView
        
    }
    func updateUIView(_ mapKitView: MapKitView, context: Context) {
        mapKitView.setLocation(with: homeVM.coreLocationManager.location)
        mapKitView.setHeading(with: homeVM.coreLocationManager.heading)
    }
}

