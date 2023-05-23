//
//  MainView.swift
//  FindVehicle
//
//  Created by ndyyy on 22/05/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM = HomeViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Hi There!")
                    .font(.largeTitle)
                    .padding(.top, 30)
                    .padding()
                
                HStack {
                    Text("IBeacon")
                        .font(.title)
                    
                    Spacer()
                    
                    Button {
                        homeVM.isAddButtonClicked = true
                    }label: {
                        Text("+")
                            .font(.title)
                    }
                }
                .padding()
                
                ScrollView {
                    LazyVGrid(columns: homeVM.gridColumn) {
                        ForEach(homeVM.ibeaconData) { item in
                            VStack(alignment: .leading) {
                                NavigationLink(destination: TrackView(homeVM: homeVM)) {
                                    Text(item.name)
                                        .foregroundColor(.white)
                                        .frame(width: 170, height: 130)
                                    
                                }
                                .simultaneousGesture(TapGesture().onEnded{
                                    
                                    homeVM.detector.stopIBeacon(item: homeVM.lastItem)
                                    
                                    homeVM.detector.item = item
                                    homeVM.detector.startIBeacon(item: item)

                                    //save last item
                                    homeVM.lastItem = item
                                })
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.blue.opacity(0.3))
                            )
                            .padding(.top, 15)
                        }
                    }
                    .padding(.top, 15)
                }
                .background(.gray.opacity(0.2))
            }
            .sheet(isPresented: $homeVM.isAddButtonClicked) {
               AddIBeaconView(homeVM: homeVM)
                    .presentationDetents([.fraction(0.9), .fraction(0.8)])
            }
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
