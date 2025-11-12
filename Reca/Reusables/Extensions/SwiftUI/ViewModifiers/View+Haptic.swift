//
//  View+Haptic.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

// MARK: - View Extensions for Haptic Feedback

extension View {

    /// Add haptic feedback to a tap gesture
    /// - Parameters:
    ///   - feedback: The haptic feedback type to play
    ///   - action: The action to perform on tap
    /// - Returns: Modified view with haptic feedback
    func onTapWithHaptic(_ feedback: HapticFeedbackType, perform action: @escaping () -> Void) -> some View {
        self.onTapGesture {
            HapticManager.shared.play(feedback)
            action()
        }
    }

    /// Add haptic feedback to a tap gesture using a predefined pattern
    /// - Parameters:
    ///   - pattern: The haptic pattern to play
    ///   - action: The action to perform on tap
    /// - Returns: Modified view with haptic feedback
    func onTapWithHaptic(_ pattern: HapticPattern, perform action: @escaping () -> Void) -> some View {
        self.onTapGesture {
            HapticManager.shared.play(pattern)
            action()
        }
    }

    /// Add haptic feedback to a long press gesture
    /// - Parameters:
    ///   - feedback: The haptic feedback type to play
    ///   - minimumDuration: Minimum duration for long press
    ///   - action: The action to perform on long press
    /// - Returns: Modified view with haptic feedback
    func onLongPressWithHaptic(
        _ feedback: HapticFeedbackType,
        minimumDuration: Double = 0.5,
        perform action: @escaping () -> Void
    ) -> some View {
        self.onLongPressGesture(minimumDuration: minimumDuration) {
            HapticManager.shared.play(feedback)
            action()
        }
    }

    /// Add haptic feedback to a long press gesture using a predefined pattern
    /// - Parameters:
    ///   - pattern: The haptic pattern to play
    ///   - minimumDuration: Minimum duration for long press
    ///   - action: The action to perform on long press
    /// - Returns: Modified view with haptic feedback
    func onLongPressWithHaptic(
        _ pattern: HapticPattern,
        minimumDuration: Double = 0.5,
        perform action: @escaping () -> Void
    ) -> some View {
        self.onLongPressGesture(minimumDuration: minimumDuration) {
            HapticManager.shared.play(pattern)
            action()
        }
    }

    /// Add haptic feedback when view appears
    /// - Parameter feedback: The haptic feedback type to play
    /// - Returns: Modified view with haptic feedback
    func hapticOnAppear(_ feedback: HapticFeedbackType) -> some View {
        self.onAppear {
            HapticManager.shared.play(feedback)
        }
    }

    /// Add haptic feedback when view appears using a predefined pattern
    /// - Parameter pattern: The haptic pattern to play
    /// - Returns: Modified view with haptic feedback
    func hapticOnAppear(_ pattern: HapticPattern) -> some View {
        self.onAppear {
            HapticManager.shared.play(pattern)
        }
    }

    /// Add haptic feedback when view disappears
    /// - Parameter feedback: The haptic feedback type to play
    /// - Returns: Modified view with haptic feedback
    func hapticOnDisappear(_ feedback: HapticFeedbackType) -> some View {
        self.onDisappear {
            HapticManager.shared.play(feedback)
        }
    }

    /// Add haptic feedback when view disappears using a predefined pattern
    /// - Parameter pattern: The haptic pattern to play
    /// - Returns: Modified view with haptic feedback
    func hapticOnDisappear(_ pattern: HapticPattern) -> some View {
        self.onDisappear {
            HapticManager.shared.play(pattern)
        }
    }

    /// Add haptic feedback when a value changes
    /// - Parameters:
    ///   - value: The value to observe for changes
    ///   - feedback: The haptic feedback type to play
    /// - Returns: Modified view with haptic feedback
    func hapticOnChange<T: Equatable>(of value: T, perform feedback: HapticFeedbackType) -> some View {
        self.onChange(of: value) { _, _ in
            HapticManager.shared.play(feedback)
        }
    }

    /// Add haptic feedback when a value changes using a predefined pattern
    /// - Parameters:
    ///   - value: The value to observe for changes
    ///   - pattern: The haptic pattern to play
    /// - Returns: Modified view with haptic feedback
    func hapticOnChange<T: Equatable>(of value: T, perform pattern: HapticPattern) -> some View {
        self.onChange(of: value) { _, _ in
            HapticManager.shared.play(pattern)
        }
    }

    /// Add haptic feedback when a boolean value changes to true
    /// - Parameters:
    ///   - value: The boolean value to observe
    ///   - feedback: The haptic feedback type to play when value becomes true
    /// - Returns: Modified view with haptic feedback
    func hapticOnTrue(of value: Bool, perform feedback: HapticFeedbackType) -> some View {
        self.onChange(of: value) { _, newValue in
            if newValue {
                HapticManager.shared.play(feedback)
            }
        }
    }

    /// Add haptic feedback when a boolean value changes to true using a predefined pattern
    /// - Parameters:
    ///   - value: The boolean value to observe
    ///   - pattern: The haptic pattern to play when value becomes true
    /// - Returns: Modified view with haptic feedback
    func hapticOnTrue(of value: Bool, perform pattern: HapticPattern) -> some View {
        self.onChange(of: value) { _, newValue in
            if newValue {
                HapticManager.shared.play(pattern)
            }
        }
    }

    /// Add haptic feedback when a boolean value changes to false
    /// - Parameters:
    ///   - value: The boolean value to observe
    ///   - feedback: The haptic feedback type to play when value becomes false
    /// - Returns: Modified view with haptic feedback
    func hapticOnFalse(of value: Bool, perform feedback: HapticFeedbackType) -> some View {
        self.onChange(of: value) { _, newValue in
            if !newValue {
                HapticManager.shared.play(feedback)
            }
        }
    }

    /// Add haptic feedback when a boolean value changes to false using a predefined pattern
    /// - Parameters:
    ///   - value: The boolean value to observe
    ///   - pattern: The haptic pattern to play when value becomes false
    /// - Returns: Modified view with haptic feedback
    func hapticOnFalse(of value: Bool, perform pattern: HapticPattern) -> some View {
        self.onChange(of: value) { _, newValue in
            if !newValue {
                HapticManager.shared.play(pattern)
            }
        }
    }
}

// MARK: - Haptic Button Helper

/// Create a button with haptic feedback
/// - Parameters:
///   - feedback: The haptic feedback type to play
///   - action: The action to perform
///   - label: The button label
/// - Returns: Button with haptic feedback
func HapticButton<Label: View>(
    _ feedback: HapticFeedbackType,
    action: @escaping () -> Void,
    @ViewBuilder label: () -> Label
) -> some View {
    Button(action: {
        HapticManager.shared.play(feedback)
        action()
    }, label: label)
}

/// Create a button with haptic pattern
/// - Parameters:
///   - pattern: The haptic pattern to play
///   - action: The action to perform
///   - label: The button label
/// - Returns: Button with haptic feedback
func HapticButton<Label: View>(
    _ pattern: HapticPattern,
    action: @escaping () -> Void,
    @ViewBuilder label: () -> Label
) -> some View {
    Button(action: {
        HapticManager.shared.play(pattern)
        action()
    }, label: label)
}

// MARK: - Haptic Toggle Helper

/// Create a toggle with haptic feedback
/// - Parameters:
///   - isOn: The binding for the toggle state
///   - onFeedback: Haptic feedback when toggle turns on
///   - offFeedback: Haptic feedback when toggle turns off
///   - label: The toggle label
/// - Returns: Toggle with haptic feedback
func HapticToggle<Label: View>(
    isOn: Binding<Bool>,
    onFeedback: HapticFeedbackType = .mediumImpact,
    offFeedback: HapticFeedbackType = .lightImpact,
    @ViewBuilder label: () -> Label
) -> some View {
    Toggle(isOn: Binding(
        get: { isOn.wrappedValue },
        set: { newValue in
            HapticManager.shared.play(newValue ? onFeedback : offFeedback)
            isOn.wrappedValue = newValue
        }
    ), label: label)
}
