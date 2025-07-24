//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Combine

public protocol IProductRepository {
    func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError>
}

public final class ProductRepository: IProductRepository {
    private let remoteDataSource: IProductRemoteDataSource

    public init(remoteDataSource: IProductRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    public func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError> {
        // In the future, we can decide between using Remote or Local data here
        return remoteDataSource.fetchProducts(page: page, limit: limit)
    }
}
