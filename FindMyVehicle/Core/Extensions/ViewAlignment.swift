//
//  Alignment.swift
//  FindVehicle
//
//  Created by ndyyy on 20/05/23.
//

import SwiftUI

extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }    
}
