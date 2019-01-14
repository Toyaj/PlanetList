//
//  CoreDataBaseLayer.swift
//  PlanetList
//
//  Created by Toyaj Nigam on 10/01/19.
//  Copyright © 2019 Toyaj Nigam. All rights reserved.
//

import UIKit
import CoreData

class CoreDataBaseLayer {
    
    static let shared = CoreDataBaseLayer()
    
    private init() {
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PlanetList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
              
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}
