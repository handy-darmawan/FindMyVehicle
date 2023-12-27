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
            }
            .tag(Tab.history)
        }
        .tabSheet(initialHeight: 110, isActive: homeVM.activeTab == .vehicle) {
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
            
            //fetch data when view is loaded
//            homeVM.coreDataManager.deleteBatch()
            homeVM.fetchActiveVehicles()
        }
    }
}

#Preview {
    HomeView()
}

