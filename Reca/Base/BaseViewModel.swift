//
//  BaseViewModel.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation
import SwiftUI

/// Base protocol for all view models in the app
@MainActor
protocol BaseViewModel: ObservableObject {
    /// The router type associated with this view model
    associatedtype Router: SwiftUIRouting

    /// Navigation state
    var shouldPush: Bool { get set }
    var shouldPresent: Bool { get set }
    var shouldPresentFullscreen: Bool { get set }
    var route: Router? { get }

    /// Loading state
    var isLoading: Bool { get set }

    /// Error handling
    var error: Error? { get set }
}

/// Default implementation for BaseViewModel
extension BaseViewModel {
    /// Default navigation state
    var shouldPush: Bool { false }
    var shouldPresent: Bool { false }
    var shouldPresentFullscreen: Bool { false }
    var route: Router? { nil }

    /// Default loading state
    var isLoading: Bool { false }

    /// Default error handling
    var error: Error? { nil }
} 
