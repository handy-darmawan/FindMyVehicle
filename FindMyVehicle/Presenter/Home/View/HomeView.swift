//
//  ContentView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @Environment(SceneDelegate.self) private var sceneDelegate
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView(selection: $homeVM.activeTab) {
            NavigationStack {
                MapKitViewRepresentable()
                    .ignoresSafeArea(edges: .top)
            }
            .tag(Tab.vehicle)
            
            NavigationStack {
                HistoryView()
                    .environmentObject(homeVM.historyVM)
            }
            .tag(Tab.history)
        }
        .tabSheet(initialHeight: homeVM.sheetHeight, isActive: homeVM.activeTab == .vehicle) {
            NavigationStack {
                showSheetContent()
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .toolbar {
                    if homeVM.isAddVechileActive {
                        addNewVehicleToolbarItem()
                    }
                    
                    leadingToolbarItem()
                    trailingToolbarItem()
                }
            }
        }
        .onAppear {
            guard sceneDelegate.tabWindow == nil else {return}
            sceneDelegate.addTabBar(homeVM)
            Task {
                await homeVM.fetchActiveVehicles()
            }
        }
    }
}

#Preview {
    HomeView()
}


//func testing() {
//    @EnvironmentObject var homeVM: HomeViewModel
//
////   homeVM.coreDataManager.deleteBatch()
//
//   DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
//       //add dummy location
//       homeVM.vehicleName = "Location1"
//       homeVM.coreLocationManager.location = CLLocationCoordinate2D(latitude: -6.1356004, longitude: 106.7824644)
//       await homeVM.addVehicle()
//
//       homeVM.vehicleName = "Location2"
//       homeVM.coreLocationManager.location = CLLocationCoordinate2D(latitude: -6.1355265, longitude: 106.7824142)
//       await homeVM.addVehicle()
//   }
//}
