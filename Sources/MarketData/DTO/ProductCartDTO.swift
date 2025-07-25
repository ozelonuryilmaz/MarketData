//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

public struct ProductCartDTO {
    public let name: String
    public let quantity: Int
    public let price: String
    
    public init(name: String, quantity: Int, price: String) {
        self.name = name
        self.quantity = quantity
        self.price = price
    }
}
