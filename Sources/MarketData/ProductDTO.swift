//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

public struct ProductDTO: Decodable {
    public let name: String
    public let image: String
    
    public init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
