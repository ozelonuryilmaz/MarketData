//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Foundation

public enum NetworkError: LocalizedError {
    case badURL
    case noInternet
    case serverError(Int)
    case decodingError
    case unknown(Error)
    
    public var errorDescription: String? {
        switch self {
        case .badURL: return "Invalid URL"
        case .noInternet: return "No internet connection"
        case .serverError(let code): return "Server returned error code \(code)"
        case .decodingError: return "Failed to decode response"
        case .unknown(let error): return error.localizedDescription
        }
    }
}
