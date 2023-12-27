//
//  TabView+TabSheet.swift
//  FindMyVehicle
//
//  Created by ndyyy on 26/12/23.
//


import SwiftUI

extension TabView {
    @ViewBuilder
    func tabSheet<SheetContent: View>(initialHeight: CGFloat = 100, sheetCornerRadius: CGFloat = 15, isActive: Bool, @ViewBuilder sheetView: () -> SheetContent) -> some View {
        if isActive {
            self.modifier(BottomSheetModifier(initialHeight: initialHeight, sheetCornerRadius: sheetCornerRadius, sheetView: sheetView()))            
        }
        else {
            self
        }
    }
}

fileprivate struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    var initialHeight: CGFloat
    var sheetCornerRadius: CGFloat
    var sheetView: SheetContent
    
    @State private var showSheet: Bool = true
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $showSheet, content: {
                sheetView
                    .presentationDetents([.height(initialHeight), .medium, .fraction(0.99)])
                    .presentationCornerRadius(sheetCornerRadius)
                    .presentationBackground(.ultraThickMaterial)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .interactiveDismissDisabled()
            })
    }
}
