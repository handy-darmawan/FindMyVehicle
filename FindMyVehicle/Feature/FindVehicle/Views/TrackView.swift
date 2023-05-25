//
//  ContentView.swift
//  FindVehicle
//
//  Created by ndyyy on 19/05/23.
//

import SwiftUI

struct TrackView: View {

    @ObservedObject var homeVM: HomeViewModel
    
    var body: some View {
        VStack {
            Text(homeVM.currentContentItem.name)
                .font(.largeTitle)
                .padding(.top, 40)
                .padding(.bottom, -20)

            //MARK: Signal Strength
            SignalStrengthComponentView(homeVM: homeVM)
            
            
            Button("Done") {
                //set the location to empty
                homeVM.lastLocation.latitude = 0
                homeVM.lastLocation.longitude = 0
            }
            .buttonStyle(.borderedProminent)

        }
        .vAlign(.top)
        .onReceive(homeVM.timer) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeIn(duration: 0.2)) {
                    homeVM.objectWillChange.send()
                }
            }
        }
    }
}

struct Trackview_Previews: PreviewProvider {
    static var previews: some View {
        TrackView(homeVM: HomeViewModel())
    }
}
