//
//  FindMyVehicleApp.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import UIKit
import SwiftUI

@main
struct FindMyVehicleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject var homeVM = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeVM)
        }
    }
}
