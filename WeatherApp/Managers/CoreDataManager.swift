//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Света Шибаева on 24.08.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext (completion: (() -> ())? = nil) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion?()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }   
    
    func getEntities<T: NSManagedObject>(
        type: T.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: type.self))
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        return (try? context.fetch(fetchRequest)) ?? []
    }
}
