//
//  FindMyVehicleApp.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import SwiftUI

//model
//data source
//repo
//usecase
//vm

//folder -> data, domain, core, prosentation

//domain -> protocol dari repo, use case, dan data source
//core -> entity dari luar, misal core data / core loc
//data -> extend protocol dari domain
//presenter -> MVVM

//1 page -> 1 MVVM

//2 page -> home, setting
//
//
////parent
//class vmhome: ObservableObject {
//    //vmsetting
//}
//
//class vmsetting: ObservableObject {
//    
//}
//

@main
struct FindMyVehicleApp: App {
    @StateObject var homeVM = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.light)
                .environmentObject(homeVM)
        }
    }
}
