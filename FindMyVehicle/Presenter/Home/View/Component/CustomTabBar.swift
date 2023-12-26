//
//  CustomTabBar.swift
//  FindMyVehicle
//
//  Created by ndyyy on 26/12/23.
//

import SwiftUI

struct CustomTabBar: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id:\.rawValue) { tab in
                    Button {
                        homeVM.activeTab = tab
                    } label: {
                        VStack {
                            Image(systemName: tab.rawValue)
                                .font(.title2)
                            
                            Text(tab.title)
                                .font(.caption)
                        }
                        .foregroundStyle(homeVM.activeTab == tab ? Color.accentColor : .gray)
                        .frame(maxWidth: .infinity)
                        .contentShape(.rect)
                    }
                }
            }
            .frame(height: 55) //default height of tabbar
        }
        .background(.regularMaterial)
    }
}
