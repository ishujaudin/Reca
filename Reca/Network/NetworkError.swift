//
//  NetworkError.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case noData
    case serverError
    case notFound
    case unauthorized
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "The URL is invalid."
        case .invalidResponse: return "Invalid response from server."
        case .noData: return "No data received from server."
        case .serverError: return "The server encountered an error."
        case .notFound: return "The resource was not found."
        case .unauthorized: return "You are unauthorized to perform this action."
        case .unknown: return "An unknown error occurred."
        }
    }
}
