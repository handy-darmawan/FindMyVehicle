//
//  SignalStrengthComponent.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/05/23.
//

import SwiftUI

struct SignalStrengthComponentView: View {
    @ObservedObject var homeVM: HomeViewModel
    @State var totalRing = 2
    var body: some View {
        VStack {
            //MARK: Signal Strength Bar
            ZStack {
                Circle()
                    .fill(.green)
                    .overlay {
                        Circle()
                            .stroke(Color.green, lineWidth: 10)
                    }
                    .frame(width: 45)
                
                
                ForEach(2..<homeVM.rangeOfSignal().0 + 1, id: \.self) { x in
                    Circle()
                        .fill(.green.opacity(0))
                        .overlay {
                            Circle()
                                .stroke(Color.green, lineWidth: 10)
                        }
                        .frame(width: 45 * CGFloat(x))
                }
                
            }
            .frame(height: 250, alignment: .center)
            
            //MARK: Signal Strength Information
            VStack {
                Text("Signal Strength")
                    .font(.title2)
                    .padding(.top, 20)
                
                Text(homeVM.rangeOfSignal().1)
                    .font(.title)
                    .foregroundColor(homeVM.rangeOfSignal().2)
                    .padding(.top, 5)
                
                Text(String(format:"You are %.0fm away from your vehicle", (homeVM.detector.accuracy == -1.0) ? homeVM.countLocationDistance() : homeVM.detector.accuracy))
                    .padding(.top, 30)
            }
        }
        .padding(.top, 60)
    }
}

struct SignalStrengthComponent_Previews: PreviewProvider {
    static var previews: some View {
        SignalStrengthComponentView(homeVM: HomeViewModel())
    }
}
