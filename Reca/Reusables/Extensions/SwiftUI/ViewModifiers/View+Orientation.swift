//
//  View+Orientation.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

// MARK: - Orientation Detection

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

// MARK: - Device Rotation View Modifier

private struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                // Set initial orientation only if valid
                let orientation = UIDevice.current.orientation
                if orientation.isValidInterfaceOrientation {
                    action(orientation)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                let orientation = UIDevice.current.orientation
                // Only trigger action for valid orientations (ignore faceUp, faceDown, unknown)
                if orientation.isValidInterfaceOrientation {
                    action(orientation)
                }
            }
    }
}

// MARK: - UIDeviceOrientation Extension

private extension UIDeviceOrientation {

    var isValidInterfaceOrientation: Bool {
        switch self {
        case .portrait, .landscapeLeft, .landscapeRight:
            return true
        default:
            // Filter out: .portraitUpsideDown, .faceUp, .faceDown, .unknown
            return false
        }
    }
}

