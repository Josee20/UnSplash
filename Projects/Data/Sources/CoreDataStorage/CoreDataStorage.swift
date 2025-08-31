//
//  CoreDataStorage.swift
//  UnSplashExample
//
//  Created by 이동기 on 6/22/25.
//

import CoreData

public final class CoreDataStorage {
    
    public static let shared = CoreDataStorage()
    
    private init() { }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        guard let bundleURL = Bundle.main.url(forResource: "DataResources", withExtension: "bundle"),
              let resourceBundle = Bundle(url: bundleURL) else {
            fatalError("DataResources.bundle not found")
        }
        
        let name = "CoreDataStorage"
        let url = resourceBundle.url(forResource: name, withExtension: "momd") ?? resourceBundle.url(forResource: name, withExtension: "mom")
        guard let modelURL = url,
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load model named \(name) in DataResources.bundle")
        }

        let container = NSPersistentContainer(name: name, managedObjectModel: model)
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() { 
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }

}
