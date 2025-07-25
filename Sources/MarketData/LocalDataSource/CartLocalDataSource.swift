//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

// CartLocalDataSource.swift (Data Layer)

import Combine
import CoreData

public protocol ICartLocalDataSource {
    func saveCartItem(_ dto: ProductCartDTO) -> AnyPublisher<Void, Error>
    func fetchCartItems() -> AnyPublisher<[ProductCartDTO], Error>
}

public final class CartLocalDataSource: ICartLocalDataSource {
    private let coreData: BaseCoreDataService<CartItemEntity, ProductCartDTO>

    public init(coreData: BaseCoreDataService<CartItemEntity, ProductCartDTO>) {
        self.coreData = coreData
    }

    public func saveCartItem(_ dto: ProductCartDTO) -> AnyPublisher<Void, Error> {
        Future { promise in
            do {
                try self.coreData.save(dto: dto)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    public func fetchCartItems() -> AnyPublisher<[ProductCartDTO], Error> {
        Future { promise in
            do {
                let items = try self.coreData.fetchAll()
                promise(.success(items))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
