//
//  test.swift
//  FindMyVehicle
//
//  Created by ndyyy on 31/12/23.
//

import Foundation


import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
//            LazyVStack {
                ForEach(0..<100) { index in
                    Text("Row \(index)")
                        .padding()
                }
//            }
        }
    }
}

#Preview {
    ContentView()
}
