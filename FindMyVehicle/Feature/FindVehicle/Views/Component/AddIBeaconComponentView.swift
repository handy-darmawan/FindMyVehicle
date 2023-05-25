//
//  AddIBeaconView.swift
//  FindVehicle
//
//  Created by ndyyy on 23/05/23.
//

import SwiftUI

struct AddIBeaconComponentView: View {
    @ObservedObject var homeVM: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                TextFieldComponentView(title: "Identifier Name", placeholder: "ex Honda Motorcycle", answer: $homeVM.iBeaconVM.name)
                    .padding(.bottom, 15)
                TextFieldComponentView(title: "IBeacon UUID", placeholder: "ex XXXX-XXX", answer: $homeVM.iBeaconVM.uuid)
                    .padding(.bottom, 15)
                TextFieldComponentView(title: "IBeacon Major", placeholder: "ex 12", answer: $homeVM.iBeaconVM.major)
                    .padding(.bottom, 15)
                TextFieldComponentView(title: "IBeacon Minor", placeholder: "ex 12", answer: $homeVM.iBeaconVM.minor)
                    .padding(.bottom, 15)
            }
            .vAlign(.top)
            .padding(.top, 30)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        homeVM.isAddButtonClicked = false
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add new IBeacon")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        //add data to coreData and array
                        homeVM.addIBeacon()
                        
                        if homeVM.isIBeaconDataWrong == false {
                            homeVM.isAddButtonClicked = false
                        }
                    }
                    .alert(isPresented: $homeVM.isIBeaconDataWrong) {
                        Alert (
                            title: Text("Wrong IBeacon Data"),
                            message: Text("Please check the IBeacon UUID, Major, Minor"),
                            dismissButton: .default(
                                Text("OK"),action: {
                                    homeVM.isAddButtonClicked = false
                                }
                            )
                        )
                    }
                }
            }
        }
    }
}

struct AddIBeaconView_Previews: PreviewProvider {
    static var previews: some View {
        AddIBeaconComponentView(homeVM: HomeViewModel())
    }
}
