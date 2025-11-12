//
//  HapticPattern.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

/// Struct defining complex haptic patterns for different UI interactions
struct HapticPattern {

    // MARK: - Properties

    /// The sequence of haptic feedback types to play
    let sequence: [HapticFeedbackType]

    /// Delays between each haptic feedback in the sequence (in seconds)
    let delays: [TimeInterval]

    /// Whether the pattern should repeat
    let repeats: Bool

    /// Number of times to repeat (ignored if repeats is false)
    let repeatCount: Int

    // MARK: - Initializers

    /// Initialize a haptic pattern with a sequence of feedback types
    /// - Parameters:
    ///   - sequence: Array of haptic feedback types
    ///   - delays: Array of delays between each feedback (should be one less than sequence count)
    ///   - repeats: Whether to repeat the pattern
    ///   - repeatCount: Number of times to repeat
    init(sequence: [HapticFeedbackType],
         delays: [TimeInterval] = [],
         repeats: Bool = false,
         repeatCount: Int = 1) {
        self.sequence = sequence
        self.delays = delays.isEmpty ? Array(repeating: 0.1, count: max(0, sequence.count - 1)) : delays
        self.repeats = repeats
        self.repeatCount = repeatCount
    }

    /// Initialize a simple single haptic feedback pattern
    /// - Parameter feedback: The haptic feedback type
    init(feedback: HapticFeedbackType) {
        self.sequence = [feedback]
        self.delays = []
        self.repeats = false
        self.repeatCount = 1
    }
}

// MARK: - Predefined Patterns

extension HapticPattern {

    // MARK: - UI Interaction Patterns

    /// Button tap pattern - light impact
    static let buttonTap = HapticPattern(feedback: .lightImpact)

    /// Button press pattern - medium impact
    static let buttonPress = HapticPattern(feedback: .mediumImpact)

    /// Button long press pattern - heavy impact
    static let buttonLongPress = HapticPattern(feedback: .heavyImpact)

    /// Selection change pattern
    static let selectionChange = HapticPattern(feedback: .selection)

    /// Toggle switch pattern - medium impact
    static let toggleSwitch = HapticPattern(feedback: .mediumImpact)

    // MARK: - Notification Patterns

    /// Success action pattern - success notification
    static let successAction = HapticPattern(feedback: .success)

    /// Error action pattern - error notification
    static let errorAction = HapticPattern(feedback: .error)

    /// Warning action pattern - warning notification
    static let warningAction = HapticPattern(feedback: .warning)

    // MARK: - Complex Patterns

    /// Double tap pattern - two light impacts with short delay
    static let doubleTap = HapticPattern(
        sequence: [.lightImpact, .lightImpact],
        delays: [0.1]
    )

    /// Confirmation pattern - light then medium impact
    static let confirmation = HapticPattern(
        sequence: [.lightImpact, .mediumImpact],
        delays: [0.15]
    )

    /// Delete action pattern - warning then error
    static let deleteAction = HapticPattern(
        sequence: [.warning, .error],
        delays: [0.2]
    )

    /// Copy action pattern - selection then light impact
    static let copyAction = HapticPattern(
        sequence: [.selection, .lightImpact],
        delays: [0.1]
    )

    /// Pull to refresh pattern - selection then success
    static let pullToRefresh = HapticPattern(
        sequence: [.selection, .success],
        delays: [0.3]
    )

    /// Loading complete pattern - three light impacts
    static let loadingComplete = HapticPattern(
        sequence: [.lightImpact, .lightImpact, .lightImpact],
        delays: [0.1, 0.1]
    )

    /// Swipe action pattern - selection feedback
    static let swipeAction = HapticPattern(feedback: .selection)

    /// Card flip pattern - medium impact
    static let cardFlip = HapticPattern(feedback: .mediumImpact)

    /// Navigation pattern - light impact
    static let navigation = HapticPattern(feedback: .lightImpact)

    /// Modal present pattern - medium impact
    static let modalPresent = HapticPattern(feedback: .mediumImpact)

    /// Modal dismiss pattern - light impact
    static let modalDismiss = HapticPattern(feedback: .lightImpact)
}

// MARK: - Pattern Validation

extension HapticPattern {

    /// Validates if the pattern is properly configured
    var isValid: Bool {
        guard !sequence.isEmpty else { return false }
        guard delays.count == sequence.count - 1 else { return false }
        guard delays.allSatisfy({ $0 >= 0 }) else { return false }
        guard repeatCount > 0 else { return false }
        return true
    }

    /// Total duration of the pattern in seconds
    var totalDuration: TimeInterval {
        return delays.reduce(0, +)
    }
}
