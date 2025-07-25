//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation
import CoreData

public final class CoreDataStack {
    public static let shared = CoreDataStack()

    public let persistentContainer: NSPersistentContainer

    public var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "MarketData")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data yüklenemedi: \(error)")
            }
        }
    }
}
