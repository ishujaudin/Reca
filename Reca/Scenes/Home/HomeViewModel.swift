//
//  HomeViewModel.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

@MainActor
final class HomeViewModel: BaseViewModel {
    typealias Router = HomeRouter

    // Routing
    @Published var shouldPush = false
    @Published var shouldPresent = false
    @Published var shouldPresentFullscreen = false
    @Published private(set) var route: Router?

    // Networking
    private let networkController: HomeNetworkController

    // Published Properties
    @Published var isLoading = false
    @Published var error: Error?
    @Published var showPassportSheet = false
    @Published var showNoRegistrationAlert = false
    @Published var uploaderCount: Int = 0

    // Orientation
    @Published var orientation = UIDeviceOrientation.unknown

    init(networkController: HomeNetworkController = HomeNetworkController()) {
        self.networkController = networkController
        // Enable orientation notifications
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }
    
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
}

// MARK: - Actions

extension HomeViewModel {
    
    func didTapRecord() {
        route = .recording
        shouldPresentFullscreen = true
    }

    func resetNavigationState() {
        shouldPush = false
        shouldPresent = false
        shouldPresentFullscreen = false
        route = nil
    }
} 
