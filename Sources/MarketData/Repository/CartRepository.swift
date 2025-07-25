//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation
import Combine

public protocol ICartRepository {
    func saveCartItem(_ item: ProductCartDTO) -> AnyPublisher<Void, Error>
    func fetchCartItems() -> AnyPublisher<[ProductCartDTO], Error>
}

// MARK: In the future, we can decide between using Remote or Local data here
public final class CartRepository: ICartRepository {
    private let localDataSource: ICartLocalDataSource

    public init(localDataSource: ICartLocalDataSource) {
        self.localDataSource = localDataSource
    }

    public func saveCartItem(_ item: ProductCartDTO) -> AnyPublisher<Void, Error> {
        localDataSource.saveCartItem(item)
    }

    public func fetchCartItems() -> AnyPublisher<[ProductCartDTO], Error> {
        localDataSource.fetchCartItems()
    }
}
