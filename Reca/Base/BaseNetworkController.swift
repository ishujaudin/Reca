//
//  BaseNetworkController.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

/// Base protocol for all network controllers in the app
protocol BaseNetworkController {
    /// The response model type associated with this network controller
    associatedtype ResponseModel
    
    /// Fetch data from the network
    /// - Returns: The response model
    func fetch() async throws -> ResponseModel
}

/// Default implementation for error handling
extension BaseNetworkController {
    /// Handle network errors
    /// - Parameter error: The error to handle
    /// - Returns: A user-friendly error message
    nonisolated func handleError(_ error: Error) -> String {
        // Default error handling
        return "An error occurred: \(error.localizedDescription)"
    }
} 