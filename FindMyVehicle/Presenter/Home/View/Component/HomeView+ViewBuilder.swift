//
//  HomeView+ViewBuilder.swift
//  FindMyVehicle
//
//  Created by ndyyy on 27/12/23.
//

import SwiftUI

extension HomeView {
    @ViewBuilder
    func addVehicleFieldView(colorScheme: ColorScheme) -> some View {
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
    }
    
    @ViewBuilder
    func emptyVehicleView() -> some View {
        VStack {
            textBuilder("No Active Vehicle", font: .title2, isBold: false)
        }
    }
    
    @ViewBuilder
    func textBuilder(_ text: String, font: Font, isBold: Bool) -> some View {
        Text(text)
            .font(font)
            .bold(isBold)
    }
    
    @ViewBuilder
    func showAllVehicleView() -> some View {
        ForEach(homeVM.activeVehicle, id: \.id) { vehicle in
            VStack(spacing: 0) {
                VehicleRowView(vehicle: vehicle)
            }
            .contentShape(Rectangle())
            .padding([.vertical, .horizontal], 10)
            .sheet(isPresented: $homeVM.isDetailViewClicked) {
                DetailView(vehicle: vehicle)
                    .presentationDetents([.medium, .fraction(0.99)])
                    .presentationBackground(.ultraThickMaterial)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .interactiveDismissDisabled()
            }
            .onTapGesture {
                homeVM.isDetailViewClicked.toggle()
            }
        }
    }
    
    @ViewBuilder
    func showSheetContent() -> some View {
        VStack {
            if (homeVM.activeVehicle.isEmpty && homeVM.isAddVechileActive) || homeVM.isAddVechileActive {
                addVehicleFieldView(colorScheme: colorScheme)
                    .padding([.leading, .top, .trailing], 20)
                Spacer()
            }
            else if homeVM.activeVehicle.isEmpty {
                emptyVehicleView()
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            else {
                showAllVehicleView()
                    .onAppear {
                        homeVM.addPin()
                    }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func toolBarActionButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            Text(title)
        })
    }
}
