//
//  CoreDataManager.swift
//  FindMyVehicle
//
//  Created by ndyyy on 24/05/23.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    let container = NSPersistentContainer(name: "IBeaconDataModel")
    
    init() {
        container.loadPersistentStores { desc, errors in
            if let error = errors {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        }
        catch {
            let error = error as NSError
            fatalError("Unresolved error \(error) \(error.code)")
        }
    }
    
    func addIBeacon(iBeaconModel: IBeaconModel, context: NSManagedObjectContext) {
        let newIBeacon = IBeaconEntity(context: context)
        newIBeacon.id = iBeaconModel.id
        newIBeacon.iBeaconUUID = iBeaconModel.uuid
        newIBeacon.iBeaconName = iBeaconModel.name
        newIBeacon.iBeaconMajor = Int32(iBeaconModel.major)
        newIBeacon.iBeaconMinor = Int32(iBeaconModel.minor)
            
        print("uuid when added: \(newIBeacon.iBeaconUUID!.uuidString)")
        save(context: context)
    }
    
    
    func deleteIBeacon(currIBeacon: NSManagedObject, context: NSManagedObjectContext) {
        container.viewContext.delete(currIBeacon)
//        context.delete(currIBeacon)
        save(context: context)
    }
    
    func deleteBatchIBeacon() {
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "IBeaconEntity")
        let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchReq)
        do {
            try container.viewContext.execute(deleteBatch)
        }
        catch {
            print("error delete batch")
        }
        
    }
    
}
