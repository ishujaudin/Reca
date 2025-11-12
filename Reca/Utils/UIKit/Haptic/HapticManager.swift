//
//  HapticManager.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import UIKit
import AVFoundation

/// Comprehensive haptic feedback manager for the app
final class HapticManager {

    // MARK: - Singleton

    static let shared = HapticManager()

    // MARK: - Properties

    /// Whether haptic feedback is enabled (uses system settings)
    private var isHapticEnabled: Bool {
        return true // Let system handle haptic preferences
    }

    /// Whether the device supports haptic feedback
    private let isHapticSupported: Bool

    /// Cache for haptic generators to improve performance
    private var impactGenerators: [UIImpactFeedbackGenerator.FeedbackStyle: UIImpactFeedbackGenerator] = [:]
    private var notificationGenerator: UINotificationFeedbackGenerator?
    private var selectionGenerator: UISelectionFeedbackGenerator?

    /// Queue for haptic operations
    private let hapticQueue = DispatchQueue(label: "com.reca.haptic", qos: .userInteractive)

    /// Currently playing patterns (for cancellation)
    private var activePatterns: Set<UUID> = []

    // MARK: - Initialization

    private init() {
        // Check if device supports haptic feedback
        self.isHapticSupported = UIDevice.current.userInterfaceIdiom == .phone

        // Initialize generators if supported
        if isHapticSupported {
            setupGenerators()
        }

        // Listen for app state changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillResignActive),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Public Methods

    /// Play a single haptic feedback
    /// - Parameter feedback: The haptic feedback type to play
    func play(_ feedback: HapticFeedbackType) {
        guard isHapticEnabled && isHapticSupported else { return }

        hapticQueue.async { [weak self] in
            self?.performHapticFeedback(feedback)
        }
    }

    /// Play a haptic pattern
    /// - Parameters:
    ///   - pattern: The haptic pattern to play
    ///   - completion: Optional completion handler called when pattern finishes
    /// - Returns: UUID that can be used to cancel the pattern
    @discardableResult
    func play(_ pattern: HapticPattern, completion: (() -> Void)? = nil) -> UUID {
        let patternId = UUID()

        guard isHapticEnabled && isHapticSupported && pattern.isValid else {
            completion?()
            return patternId
        }

        activePatterns.insert(patternId)

        hapticQueue.async { [weak self] in
            self?.performHapticPattern(pattern, id: patternId, completion: completion)
        }

        return patternId
    }

    /// Cancel a playing haptic pattern
    /// - Parameter patternId: The UUID of the pattern to cancel
    func cancelPattern(_ patternId: UUID) {
        hapticQueue.async { [weak self] in
            self?.activePatterns.remove(patternId)
        }
    }

    /// Cancel all playing haptic patterns
    func cancelAllPatterns() {
        hapticQueue.async { [weak self] in
            self?.activePatterns.removeAll()
        }
    }

    /// Enable or disable haptic feedback (cancels all patterns when disabled)
    /// Note: This only affects the current session, system settings are respected
    func setHapticEnabled(_ enabled: Bool) {
        if !enabled {
            cancelAllPatterns()
        }
    }

    /// Check if haptic feedback is enabled
    var isEnabled: Bool {
        return isHapticEnabled && isHapticSupported
    }

    /// Prepare haptic generators for optimal performance
    /// Call this before you know you'll need haptic feedback
    func prepareHaptics() {
        guard isHapticEnabled && isHapticSupported else { return }

        hapticQueue.async { [weak self] in
            self?.prepareAllGenerators()
        }
    }
}

// MARK: - Private Methods

private extension HapticManager {

    /// Setup haptic generators
    func setupGenerators() {
        // Initialize impact generators
        impactGenerators[.light] = UIImpactFeedbackGenerator(style: .light)
        impactGenerators[.medium] = UIImpactFeedbackGenerator(style: .medium)
        impactGenerators[.heavy] = UIImpactFeedbackGenerator(style: .heavy)

        // Initialize notification generator
        notificationGenerator = UINotificationFeedbackGenerator()

        // Initialize selection generator
        selectionGenerator = UISelectionFeedbackGenerator()
    }

    /// Prepare all generators for optimal performance
    func prepareAllGenerators() {
        impactGenerators.values.forEach { $0.prepare() }
        notificationGenerator?.prepare()
        selectionGenerator?.prepare()
    }

    /// Perform a single haptic feedback
    func performHapticFeedback(_ feedback: HapticFeedbackType) {
        switch feedback {
        case .impact(let style):
            impactGenerators[style]?.impactOccurred()

        case .notification(let type):
            notificationGenerator?.notificationOccurred(type)

        case .selection:
            selectionGenerator?.selectionChanged()
        }
    }

    /// Perform a haptic pattern
    func performHapticPattern(_ pattern: HapticPattern, id: UUID, completion: (() -> Void)?) {
        let totalRepeats = pattern.repeats ? pattern.repeatCount : 1

        performPatternIteration(pattern, id: id, currentRepeat: 0, totalRepeats: totalRepeats) { [weak self] in
            self?.activePatterns.remove(id)
            DispatchQueue.main.async {
                completion?()
            }
        }
    }

    /// Perform a single iteration of a haptic pattern
    func performPatternIteration(_ pattern: HapticPattern, id: UUID, currentRepeat: Int, totalRepeats: Int, completion: @escaping () -> Void) {
        guard activePatterns.contains(id) && currentRepeat < totalRepeats else {
            completion()
            return
        }

        performSequence(pattern.sequence, delays: pattern.delays, index: 0) { [weak self] in
            guard let self = self else {
                completion()
                return
            }

            // Schedule next iteration if needed
            if currentRepeat + 1 < totalRepeats {
                self.hapticQueue.asyncAfter(deadline: .now() + 0.1) {
                    self.performPatternIteration(pattern, id: id, currentRepeat: currentRepeat + 1, totalRepeats: totalRepeats, completion: completion)
                }
            } else {
                completion()
            }
        }
    }

    /// Perform a sequence of haptic feedback with delays
    func performSequence(_ sequence: [HapticFeedbackType], delays: [TimeInterval], index: Int, completion: @escaping () -> Void) {
        guard index < sequence.count else {
            completion()
            return
        }

        // Perform current haptic feedback
        performHapticFeedback(sequence[index])

        // Schedule next feedback if exists
        if index + 1 < sequence.count {
            let delay = index < delays.count ? delays[index] : 0.1
            hapticQueue.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.performSequence(sequence, delays: delays, index: index + 1, completion: completion)
            }
        } else {
            completion()
        }
    }

    /// Handle app becoming active
    @objc func appDidBecomeActive() {
        if isHapticSupported {
            setupGenerators()
        }
    }

    /// Handle app resigning active
    @objc func appWillResignActive() {
        cancelAllPatterns()
    }
}

// MARK: - Convenience Methods

extension HapticManager {

    /// Play light impact feedback
    func playLightImpact() {
        play(.lightImpact)
    }

    /// Play medium impact feedback
    func playMediumImpact() {
        play(.mediumImpact)
    }

    /// Play heavy impact feedback
    func playHeavyImpact() {
        play(.heavyImpact)
    }

    /// Play selection feedback
    func playSelection() {
        play(.selection)
    }

    /// Play success notification
    func playSuccess() {
        play(.success)
    }

    /// Play error notification
    func playError() {
        play(.error)
    }

    /// Play warning notification
    func playWarning() {
        play(.warning)
    }
}
