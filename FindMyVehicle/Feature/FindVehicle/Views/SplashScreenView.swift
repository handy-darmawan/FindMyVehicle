//
//  SplashScreen.swift
//  FindVehicle
//
//  Created by ndyyy on 20/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var scaling = 0.7
    @State private var opacity = 0.9

    var body: some View {
        VStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                Text("Find your vehicle")
                    .font(.largeTitle)
            }
            .scaleEffect(scaling)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.4)) {
                    self.opacity = 1
                    self.scaling = 0.9
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 0.6)) {
//                    HomeView()
                }
            }
        }
    }
}
