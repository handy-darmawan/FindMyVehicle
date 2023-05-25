//
//  IBeaconComponentView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/05/23.
//

import SwiftUI

struct IBeaconComponentView: View {
    @ObservedObject var homeVM: HomeViewModel

    var iBeaconCoreData: FetchedResults<IBeaconEntity>
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if homeVM.ibeaconData.count != 0 {
                LazyVGrid(columns: homeVM.gridColumn) {
                    ForEach(homeVM.ibeaconData.indices, id: \.self) { idx in
                        let item = homeVM.ibeaconData[idx]
                        VStack(alignment: .leading) {
                            NavigationLink(destination: TrackView(homeVM: homeVM, item: item, iBeaconCoreData: iBeaconCoreData)) {
                                Text(item.name)
                                    .foregroundColor(.white)
                                    .frame(width: 170, height: 130)
                            }
                            .simultaneousGesture(TapGesture().onEnded{
                                
                                //stop previous connection
                                homeVM.detector.stopIBeacon(item: homeVM.lastItem)
                                
                                //start new connection
                                homeVM.detector.item = item
                                homeVM.detector.startIBeacon(item: item)
                                
                                //set current IBeacon item
                                homeVM.currentContentItem = item

                                //store last iBeacon data
                                homeVM.lastItem = item
        
                                //set location latitude longitude if there's not filled
                                if homeVM.lastLocation.latitude == 0 && homeVM.lastLocation.longitude == 0 {
                                    homeVM.lastLocation = homeVM.detector.lastLocation
                                }
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
            else {
                Text("There's no iBeacon registered")
                    .hAlign(.center)
                    .padding(.top, 300)
                    
            }
        }
        .background(.gray.opacity(0.2))
    }
}
