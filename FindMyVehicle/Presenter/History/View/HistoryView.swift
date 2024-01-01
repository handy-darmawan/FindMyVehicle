//
//  HistoryView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 25/12/23.
//

import Foundation
import SwiftUI


struct HistoryView: View {
    @EnvironmentObject var historyVM: HistoryViewModel
    var body: some View {
        VStack {
            if historyVM.vehicles.isEmpty {
                Text("No History")
                    .font(.title2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            else {
                Text("Last Parked Vehicle")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                List {
                    ForEach(historyVM.vehicles, id: \.id) { vehicle in
                        HStack {
                            Text(vehicle.name)
                                .font(.title3)
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
            Task {
                await historyVM.fetchVehicles()
            }
        }
    }
}
