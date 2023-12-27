//
//  VerticalScrollView+Geometry.swift
//  FindMyVehicle
//
//  Created by ndyyy on 27/12/23.
//

import SwiftUI


struct VScrollView<Content>: View where Content: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                content
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
            }
            
        }
    }
}
