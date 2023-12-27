//
//  CoreDataManager.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import Foundation
import CoreData
import CoreLocation


class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VehicleCoreData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    private init() {}
    
    func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        }
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

extension CoreDataManager: CoreDataProtocol {
    func addVehicleLocation(vehicle: VehicleModel) {
        let _ = vehicle.toEntity(context: context)
        saveContext()
    }
    
    func fetchAllVehicleLocation() -> [VehicleModel] {
        let vehicle = NSFetchRequest<Vehicle>(entityName: "Vehicle")
        
        do {
            let results = try context.fetch(vehicle)
            //map from entity to model
            return results.map { VehicleModel.toModel($0) }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return []
    }
    
    func deleteVehicle(for id: UUID) {
        let vehicle = NSFetchRequest<Vehicle>(entityName: "Vehicle")
        vehicle.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try context.fetch(vehicle)
            results.forEach { context.delete($0) }
            saveContext()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func deleteBatch() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Vehicle")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
        }
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
