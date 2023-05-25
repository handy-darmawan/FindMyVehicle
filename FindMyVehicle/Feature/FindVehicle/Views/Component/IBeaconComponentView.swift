//
//  IBeaconComponentView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/05/23.
//

import SwiftUI

struct IBeaconComponentView: View {
    @ObservedObject var homeVM: HomeViewModel
//    @ObservedObject var coreDM: CoreDataManager
//
    var iBeaconCoreData: FetchedResults<IBeaconEntity>
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: homeVM.gridColumn) {
                ForEach(homeVM.ibeaconData) { item in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: TrackView(homeVM: homeVM)) {
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
                .onDelete { IndexSet in
                    for index in IndexSet {
                        print(IndexSet.count)
                        print(index)
                        let currentIBeacon = iBeaconCoreData[index]
                        homeVM.coreDM.deleteIBeacon(currIBeacon: currentIBeacon, context: homeVM.moc)
                        
                    }
                }
            }
            .padding(.top, 15)
        }
        .background(.gray.opacity(0.2))
    }
}

//struct IBeaconComponentView_Previews: PreviewProvider {
//    static var previews: some View {
//        IBeaconComponentView(homeVM: HomeViewModel())
//    }
//}
