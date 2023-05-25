//
//  MainView.swift
//  FindVehicle
//
//  Created by ndyyy on 22/05/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @ObservedObject var coreDM: CoreDataManager

    //MARK: CoreData
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: IBeaconEntity.entity(), sortDescriptors: []) var iBeaconCoreData: FetchedResults<IBeaconEntity>
    
    var body: some View {
        NavigationStack {
            
            if homeVM.isSplashScreenShown {
                SplashScreenView(homeVM: homeVM)
            }
            else {
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
                    
                    //MARK: Show IBeacon View
                    IBeaconComponentView(homeVM: homeVM, iBeaconCoreData: iBeaconCoreData)
                }
                .sheet(isPresented: $homeVM.isAddButtonClicked) {
                    AddIBeaconComponentView(homeVM: homeVM)
                        .presentationDetents([.fraction(0.9), .fraction(0.8)])
                }
            }
        }
        .onAppear {
            homeVM.fillIBeaconData(iBeaconCoreData: iBeaconCoreData)
            homeVM.coreDM = coreDM
            homeVM.moc = moc
            
            //testing to clear all coredata
            homeVM.coreDM.deleteBatchIBeacon()
        }
//        .onChange(of: homeVM.ibeaconData) { _ in
//            homeVM.fillIBeaconData(iBeaconCoreData: iBeaconCoreData)
//        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coreDM: CoreDataManager())
    }
}
