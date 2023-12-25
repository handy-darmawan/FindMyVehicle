//
//  MapKitView+UIRepresentable.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/12/23.
//

import SwiftUI
import MapKit

struct MapKitViewRepresentable: UIViewRepresentable {
    @Binding var location: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MapKitView {
        let mapkitView = MapKitView()
        return mapkitView
        
    }
    func updateUIView(_ mapKitView: MapKitView, context: Context) {
        mapKitView.setCurrentLocation(with: location)
    }
}

