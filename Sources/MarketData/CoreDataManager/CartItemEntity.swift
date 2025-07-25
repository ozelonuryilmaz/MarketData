//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import CoreData

@objc(CartItemEntity)
public class CartItemEntity: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var quantity: Int16
    @NSManaged public var price: String
}

extension CartItemEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItemEntity> {
        return NSFetchRequest<CartItemEntity>(entityName: "CartItemEntity")
    }
}
