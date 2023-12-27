//
//  ContentView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import UIKit
import SwiftUI
import CoreLocation
import MapKit

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
                Text("ACTIVE TAB: \(homeVM.activeTab.title)")
                HistoryView()
            }
            .tag(Tab.history)
        }
        .tabSheet(initialHeight: 110, isActive: homeVM.activeTab == .vehicle) {
            NavigationStack {
                VScrollView() {
                    if (homeVM.activeVehicle.isEmpty && homeVM.isAddVechileActive) || homeVM.isAddVechileActive {
                        VStack(alignment: .leading) {
                            Text("Vehicle Name")
                                .font(.headline.bold())
                                .padding(.top, 20)
                            TextField("Your vehicle name", text: $homeVM.vehicleName)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 2)
                                )
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .onSubmit {
                                    //add to coredata
                                    homeVM.addVehicle()
                                    homeVM.fetchActiveVehicles()
                                }
                        }
                        .frame(alignment: .leading)
                        .padding([.leading, .top, .trailing], 20)
                        Spacer()
                    }
                    else if homeVM.activeVehicle.isEmpty {
                        VStack {
                            Text("No Active Vehicle")
                                .font(.title2.bold())
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                    }
                    else {
                        ForEach(homeVM.activeVehicle, id: \.id) { vehicle in
                            VStack(spacing: 0) {
                                VehicleRowView(vehicle: vehicle)
                            }
                            .padding([.vertical, .horizontal], 10)
                        }
                        Spacer()
                    }
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .toolbar {
                    if homeVM.isAddVechileActive {
                        ToolbarItem(placement: .principal) {
                            Text("Add New Vehicle")
                                .font(.title3.bold())
                            
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        if homeVM.isAddVechileActive {
                            Button(action: {
                                homeVM.isAddVechileActive.toggle()
                            }, label: {
                                Text("Cancel")
                            })
                        }
                        else {
                            Text(homeVM.activeTab.title)
                                .font(.title2.bold())
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if homeVM.isAddVechileActive {
                            Button(action: {
                                homeVM.addVehicle()
                                homeVM.fetchActiveVehicles()
                            }, label: {
                                Text("Done")
                            })
                        }
                        else {
                            Button(action: {
                                homeVM.isAddVechileActive.toggle()
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }
                    }
                }
            }
        }
        .onAppear {
            guard sceneDelegate.tabWindow == nil else {return}
            sceneDelegate.addTabBar(homeVM)
            
            print(homeVM.activeTab)
            
            homeVM.coreDataManager.deleteBatch()
            //fetch data when view is loaded
            homeVM.fetchActiveVehicles()
        }
    }
}

#Preview {
    HomeView()
}
