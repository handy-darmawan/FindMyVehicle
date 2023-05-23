//
//  ContentView.swift
//  FindVehicle
//
//  Created by ndyyy on 19/05/23.
//

import SwiftUI

struct TrackView: View {

//    @StateObject var iBeaconDetector = IBeaconDetector()
    @ObservedObject var homeVM: HomeViewModel
    var body: some View {
        VStack {
            switch homeVM.detector.lastDistance {
            case .unknown:
                Text("Out of area")
            case .far:
                Text("Far")
            case .near:
                Text("Near")
            case .immediate:
                Text("Close to you")
            @unknown default:
                Text("Out of area")
            }

            
            Text("\(homeVM.detector.item.uuid.uuidString)")
            Text(String(format:"Accuracy: %0.2f", homeVM.detector.accuracy))
            
        }
    }
}

//struct TrackVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackView(iBeaconData: IBeaconModel(uuid: UUID(), name: "hi", major: 12, minor: 12))
//    }
//}
