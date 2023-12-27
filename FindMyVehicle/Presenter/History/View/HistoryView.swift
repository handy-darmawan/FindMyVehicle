//
//  HistoryView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 25/12/23.
//

import Foundation
import SwiftUI


struct HistoryView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    var body: some View {
        VStack {
            if homeVM.vehicles.isEmpty {
                Text("No History")
                    .font(.title2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            else {
                List {
                    ForEach(homeVM.vehicles, id: \.id) { vehicle in
                        HStack {
                            Image(systemName: "car.fill")
                                .font(.title2)
                                .background(.background, in: Circle())
                            
                            Text(vehicle.name)
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(vehicle.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            homeVM.fetchVehicles()
        }
    }
}
