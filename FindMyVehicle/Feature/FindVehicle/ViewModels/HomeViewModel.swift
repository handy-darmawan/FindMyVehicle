//
//  HomeViewModel.swift
//  FindVehicle
//
//  Created by ndyyy on 22/05/23.
//

import SwiftUI
import CoreLocation
import CoreData

class HomeViewModel: ObservableObject {
    
    @Published var iBeaconVM = IBeaconViewModel()
    @Published var detector = IBeaconDetector()
    
    //MARK: CoreData
    @Published var coreDM = CoreDataManager()
    @Published var moc = NSManagedObjectContext()
    
    //MARK: SplashScreen Attribute
    @Published var scaling = 0.7
    @Published var opacity = 0.9
    @Published var isSplashScreenShown = true
    
    
    //MARK: HomeView Attribute & Method
    @Published var lastItem = IBeaconModel(uuid: UUID(uuidString: "C9616ADC-E4F3-4DC5-892E-86174E0CB0E6")!, name: "mCar", major: 222, minor: 156)
    @Published var isAddButtonClicked: Bool = false
    @Published var isIBeaconDataWrong: Bool = false
    
    var gridColumn = [GridItem(), GridItem()]

    @Published var ibeaconData: [IBeaconModel] = [
//        IBeaconModel(uuid: UUID(uuidString: "CB10023F-A318-3394-4199-A8730C7C1AEC")!, name: "cMotorcycle", major: 222, minor: 156),
//        IBeaconModel(uuid: UUID(uuidString: "C9616ADC-E4F3-4DC5-892E-86174E0CB0E6")!, name: "mCar", major: 222, minor: 156)
    ]
    
    func fillIBeaconData(iBeaconCoreData: FetchedResults<IBeaconEntity>) {
        //clear all array
        deleteAllIBeaconData()

        print("Total data in CoreData: \(iBeaconCoreData.count)")
        //start fill array
        for data in iBeaconCoreData {
            iBeaconVM.newIBeacon.major = Int(data.iBeaconMajor)
            iBeaconVM.newIBeacon.minor = Int(data.iBeaconMinor)
            iBeaconVM.newIBeacon.name = data.iBeaconName!
            iBeaconVM.newIBeacon.uuid = data.iBeaconUUID!
            
            ibeaconData.append(iBeaconVM.newIBeacon)
            print("UUID from CoreData -> \(iBeaconVM.uuid)")
        }
    }
    
    func deleteAllIBeaconData() {
        ibeaconData.removeAll()
    }
    
    func addIBeacon() {
        if UUID(uuidString: iBeaconVM.uuid) == nil {
            self.isIBeaconDataWrong = true
        }
        else  {
            iBeaconVM.newIBeacon.uuid = UUID(uuidString: iBeaconVM.uuid)!
            iBeaconVM.newIBeacon.major = Int(iBeaconVM.major)!
            iBeaconVM.newIBeacon.minor = Int(iBeaconVM.minor)!
            iBeaconVM.newIBeacon.name = iBeaconVM.name
            
            //save to array
            ibeaconData.append(iBeaconVM.newIBeacon)
            
            //save to coredata
            coreDM.addIBeacon(iBeaconModel: iBeaconVM.newIBeacon,
                              context: moc)
        }

        //clear data from textfield
        clearTextField()
    }
    
    func deleteIBeacon(item: IBeaconModel, iBeaconCoreData: FetchedResults<IBeaconEntity>) {
        let itemUUID = item.uuid
        
        //delete from coredata
        for data in iBeaconCoreData {
            if data.iBeaconUUID == itemUUID {
                coreDM.deleteIBeacon(currIBeacon: data, context: moc)
                break;
            }
        }
            
        //delete from array
        if let index = self.ibeaconData.firstIndex(of: item) {
            ibeaconData.remove(at: index)
        }
    }
    
    func clearTextField() {
        iBeaconVM.major = ""
        iBeaconVM.minor = ""
        iBeaconVM.uuid = ""
        iBeaconVM.name = ""
    }
    
    
    //MARK: TrackView Attribute & Method
    @Published var currentContentItem = IBeaconModel(uuid: UUID(uuidString: "C9616ADC-E4F3-4DC5-892E-86174E0CB0E6")!, name: "mCar", major: 222, minor: 156)
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @Published var lastLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    
    func rangeOfSignal() -> (Int, String, Color) {
        switch detector.lastDistance {
        case .immediate:
            return (5, "Very Strong", AppColor.green)
        case .near:
            return (5, "Very Strong", AppColor.green)
        case .far:
            return (3, "Strong", AppColor.orange)
        case .unknown:
            return (1, "Very Poor", AppColor.red)
        @unknown default:
            return (1, "Very Poor", AppColor.red)
        }
    }
    
    func countLocationDistance() -> Double {
        let lastLocation = CLLocation(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
        let currentLocation = CLLocation(latitude: detector.lastLocation.latitude, longitude: detector.lastLocation.longitude)
        
        print(lastLocation.distance(from: currentLocation))
        return lastLocation.distance(from: currentLocation)
    }


}
