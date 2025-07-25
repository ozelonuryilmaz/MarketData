//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

public struct ProductDTO: Decodable {
    public let image: String
    public let name: String
    
    public init(image: String, name: String) {
        self.name = name
        self.image = image
    }
}
