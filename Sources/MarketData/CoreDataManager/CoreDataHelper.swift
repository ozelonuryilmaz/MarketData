//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation
import CoreData

public enum CoreDataModel: String {
    case marketData = "MarketData"
}

public protocol ICoreDataHelper: AnyObject {
    var viewContext: NSManagedObjectContext { get }
    func saveContext()
    func getManagedContextWithMergePolicy() -> NSManagedObjectContext
}

public final class CoreDataHelper: ICoreDataHelper {

    private let persistentContainer: NSPersistentContainer

    public init(container: CoreDataModel = .marketData) {
        self.persistentContainer = NSPersistentContainer(name: container.rawValue)
        self.persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Core Data yüklenirken hata oluştu: \(error.localizedDescription)")
            }
        }
    }

    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public func saveContext() {
        let context = viewContext
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch {
            print("Core Data kaydetme hatası: \(error.localizedDescription)")
        }
    }

    public func getManagedContextWithMergePolicy() -> NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        return context
    }
}
