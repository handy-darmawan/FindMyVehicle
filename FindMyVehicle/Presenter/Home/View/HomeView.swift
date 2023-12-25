//
//  ContentView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel

    var body: some View {
        VStack {
            MapKitViewRepresentable(location: $homeVM.coreLocationManager.location)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    HomeView()
}
