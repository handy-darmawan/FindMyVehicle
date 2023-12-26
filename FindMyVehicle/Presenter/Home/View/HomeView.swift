//
//  ContentView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import UIKit
import SwiftUI
import CoreLocation

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @Environment(SceneDelegate.self) private var sceneDelegate
    
    var body: some View {
        TabView(selection: $homeVM.activeTab) {
            NavigationStack {
                MapKitViewRepresentable(location: $homeVM.coreLocationManager.location)
                    .ignoresSafeArea(edges: .top)
            }
            .tag(Tab.vehicle)
            
            NavigationStack {
                Text(homeVM.activeTab.title)
            }
            
        }
        .tabSheet(initialHeight: 110, isActive: homeVM.activeTab == .vehicle) {
            NavigationStack {
                ScrollView {
                    ForEach(homeVM.vehicles, id: \.id) { vehicle in
                        VStack(spacing: 0) {
                            VehicleRowView(vehicle: vehicle)
                        }
                        .padding([.vertical, .horizontal], 10)
                    }
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text(homeVM.activeTab.title)
                            .font(.title2.bold())
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
//                            print("Function to Add Vehicle")
                            //trial to add data to coredata
                            homeVM.addVehicle(with: "data", location: CLLocationCoordinate2D(latitude: 10, longitude: 10))
                            print("saved")
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            }
        }
        .onAppear {
            guard sceneDelegate.tabWindow == nil else {return}
            sceneDelegate.addTabBar(homeVM)
            
            //fetch data when view is loaded
            homeVM.fetchVehicles()
        }
    }
}

#Preview {
    HomeView()
}
