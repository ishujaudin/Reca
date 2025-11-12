//
//  AppStorageManager.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI
import CoreLocation

// MARK: - Keys

extension AppStorageManager {
    enum Key {
        static let username = "username"
        static let phone = "phone"
        static let onboardingCompleted = "onboardingCompleted"
        static let lastScannedMRZ = "lastScannedMRZ"
        static let userCurrentLocation = "userCurrentLocation"
        static let savedLocations = "savedLocations"
        static let locationPermissionStatus = "locationPermissionStatus"
    }
}

// MARK: - AppStorageManager

struct AppStorageManager {
    @AppStorage(Key.username) static var username: String = ""
    @AppStorage(Key.phone) static var phone: String = ""
    @AppStorage(Key.onboardingCompleted) static var onboardingCompleted: Bool = false
    @AppStorage(Key.lastScannedMRZ) static var lastScannedMRZ: String = ""
    @AppStorage(Key.userCurrentLocation) static var userCurrentLocation: Data = Data()
    @AppStorage(Key.savedLocations) static var savedLocations: Data = Data()
    @AppStorage(Key.locationPermissionStatus) static var locationPermissionStatus: Int = Int(CLAuthorizationStatus.notDetermined.rawValue)
}

// MARK: - Onboarding Methods

extension AppStorageManager {

    static func setOnboardingCompleted() {
        onboardingCompleted = true
    }

    static func isOnboardingCompleted() -> Bool {
        return onboardingCompleted
    }
}

// MARK: - Saving Methods

extension AppStorageManager {

  
}
