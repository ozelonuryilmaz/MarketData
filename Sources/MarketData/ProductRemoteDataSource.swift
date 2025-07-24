//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Combine
import Foundation

public protocol IProductRemoteDataSource {
    func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError>
}

public final class ProductRemoteDataSource: IProductRemoteDataSource {
    private let networkManager: NetworkManager

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    public func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError> {
        guard let url = URL(string: "https://5fc9346b2af77700165ae514.mockapi.io/products?page=\(page)&limit=\(limit)") else {
            return Fail(error: .badURL).eraseToAnyPublisher()
        }

        let request = HTTPRequest(url: url, method: .get)
        return networkManager.request(request)
    }
}
