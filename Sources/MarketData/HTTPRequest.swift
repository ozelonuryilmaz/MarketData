//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Foundation

public struct HTTPRequest {
    public let url: URL
    public let method: HTTPMethod
    public let headers: [String: String]?
    public let body: Data?
    
    public init(url: URL, method: HTTPMethod = .get, headers: [String: String]? = nil, body: Data? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
    
    public init<E: Encodable>(url: URL, method: HTTPMethod = .post, headers: [String: String]? = ["Content-Type": "application/json"], bodyObject: E) {
        let encoder = JSONEncoder()
        let body = try? encoder.encode(bodyObject)
        self.init(url: url, method: method, headers: headers, body: body)
    }
}
