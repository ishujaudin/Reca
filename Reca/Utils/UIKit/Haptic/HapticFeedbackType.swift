//
//  HapticFeedbackType.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import UIKit

/// Enum defining different types of haptic feedback available in the app
enum HapticFeedbackType {

    // MARK: - Impact Feedback
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)

    // MARK: - Notification Feedback
    case notification(UINotificationFeedbackGenerator.FeedbackType)

    // MARK: - Selection Feedback
    case selection

    // MARK: - Convenience Cases

    /// Light impact feedback for subtle interactions
    static let lightImpact = HapticFeedbackType.impact(.light)

    /// Medium impact feedback for standard interactions
    static let mediumImpact = HapticFeedbackType.impact(.medium)

    /// Heavy impact feedback for strong interactions
    static let heavyImpact = HapticFeedbackType.impact(.heavy)

    /// Success notification feedback
    static let success = HapticFeedbackType.notification(.success)

    /// Warning notification feedback
    static let warning = HapticFeedbackType.notification(.warning)

    /// Error notification feedback
    static let error = HapticFeedbackType.notification(.error)
}