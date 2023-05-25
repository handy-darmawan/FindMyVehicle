//
//  SplashScreen.swift
//  FindVehicle
//
//  Created by ndyyy on 20/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var homeVM: HomeViewModel
    
    var body: some View {
        VStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                Text("Find My Vehicle")
                    .font(.largeTitle)
            }
            .scaleEffect(homeVM.scaling)
            .opacity(homeVM.opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.4)) {
                    homeVM.opacity = 1
                    homeVM.scaling = 0.9
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 0.6)) {
                    //Show HomeView
                    homeVM.isSplashScreenShown = false
                }
            }
        }
    }
}
