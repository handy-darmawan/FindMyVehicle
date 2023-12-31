//
//  HomeView+ToolbarItemExt.swift
//  FindMyVehicle
//
//  Created by ndyyy on 27/12/23.
//

import SwiftUI

//MARK: ToolbarItem
extension HomeView {
    
    func addNewVehicleToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            textBuilder("Add New Vehicle", font: .title3, isBold: true)
        }
    }
    
    func leadingToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            if homeVM.isAddVechileActive {
                toolBarActionButton("Cancel") {
                    homeVM.isAddVechileActive.toggle()
                }
            }
            else {
                textBuilder(homeVM.activeTab.title, font: .title2, isBold: true)
            }
        }
    }

    func trailingToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if homeVM.isAddVechileActive {
                toolBarActionButton("Done") {
                    homeVM.addVehicle()
                    homeVM.fetchActiveVehicles()
                }
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
