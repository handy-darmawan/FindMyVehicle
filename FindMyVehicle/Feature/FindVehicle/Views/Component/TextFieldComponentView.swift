//
//  TextFieldComponentView.swift
//  FindVehicle
//
//  Created by ndyyy on 23/05/23.
//

import SwiftUI

struct TextFieldComponentView: View {
    var title: String
    var placeholder: String
    @Binding var answer: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding([.horizontal, .bottom], 15)
            
            TextField(placeholder, text: $answer)
                .padding(.horizontal, 15)
                .keyboardType((title.contains("Minor") || title.contains("Minor")) ? .numberPad : .default)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.9), lineWidth: 2)
                        .frame(width: 340, height: 50)
                }
        }
        .padding(.horizontal, 30)
    }
}

