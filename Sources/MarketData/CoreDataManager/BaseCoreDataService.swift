//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import CoreData

public class BaseCoreDataService<Entity: NSManagedObject, DTO> {
    let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.context = context
    }

    func mapToDTO(entity: Entity) -> DTO {
        fatalError("Subclasses must override mapToDTO")
    }

    func mapToEntity(dto: DTO, entity: Entity) {
        fatalError("Subclasses must override mapToEntity")
    }

    public func save(dto: DTO) throws {
        let entity = Entity(context: context)
        mapToEntity(dto: dto, entity: entity)
        try context.save()
    }

    public func fetchAll() throws -> [DTO] {
        let request = Entity.fetchRequest()
        guard let result = try context.fetch(request) as? [Entity] else {
            return []
        }
        return result.map { self.mapToDTO(entity: $0) }
    }
}
