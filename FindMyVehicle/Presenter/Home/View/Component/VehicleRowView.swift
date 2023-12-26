//
//  VehicleRowView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 26/12/23.
//


import SwiftUI

struct VehicleRowView: View {
    let vehicle: VehicleModel
    
    var body: some View {
        HStack {
            Image(systemName: "car.fill")
                .font(.title2)
                .padding(12)
                .background(.background, in: .circle)
            
            VStack(spacing: 0) {
                Text(vehicle.name)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("X km")
                .font(.callout)
                .foregroundColor(.gray)
        }
    }
}
