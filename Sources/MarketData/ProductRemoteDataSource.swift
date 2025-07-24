//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Combine
import Foundation

internal protocol IProductRemoteDataSource {
    func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError>
}

internal final class ProductRemoteDataSource: IProductRemoteDataSource {
    private let networkManager: INetworkManager

    internal init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }

    internal func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError> {
        guard let url = URL(string: "https://5fc9346b2af77700165ae514.mockapi.io/products?page=\(page)&limit=\(limit)") else {
            return Fail(error: .badURL).eraseToAnyPublisher()
        }

        let request = HTTPRequest(url: url, method: .get)
        return networkManager.request(request)
    }
}
