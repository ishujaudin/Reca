//
//  RAToast.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

// MARK: - RAToast Type

enum RAToastType {
    case success
    case error
    case warning
    case info
    case custom(String)

    var icon: String {
        switch self {
        case .success:
            return "checkmark.circle"
        case .error:
            return "xmark.circle"
        case .warning:
            return "exclamationmark.triangle"
        case .info:
            return "info.circle"
        case .custom(let iconName):
            return iconName
        }
    }

    var tintColor: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        case .warning:
            return .orange
        case .info:
            return .blue
        case .custom:
            return .white
        }
    }
}

// MARK: - RAToast Model

struct RAToastModel {
    let id = UUID()
    let type: RAToastType
    let message: String
    let actionTitle: String?
    let actionHandler: (() -> Void)?
    let duration: TimeInterval

    init(
        type: RAToastType = .success,
        message: String,
        actionTitle: String? = nil,
        actionHandler: (() -> Void)? = nil,
        duration: TimeInterval = 2.0
    ) {
        self.type = type
        self.message = message
        self.actionTitle = actionTitle
        self.actionHandler = actionHandler
        self.duration = duration
    }
}

// MARK: - RAToast View

struct RAToast: View {
    let model: RAToastModel
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: model.type.icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(model.type.tintColor)

            // Message
            Text(model.message)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)

            // Action Button (Optional)
            if let actionTitle = model.actionTitle,
               let actionHandler = model.actionHandler {
                Button(action: {
                    actionHandler()
                    onDismiss()
                }) {
                    Text(actionTitle)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(model.type.tintColor)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.2))
                        )
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            Capsule()
                .fill(Global.theme.darkBackgroundColor.color)
        )
        .onTapGesture {
            // Dismiss on any tap interaction
            onDismiss()
        }
    }
}

// MARK: - RAToastManager

class RAToastManager: ObservableObject {
    static let shared = RAToastManager()

    @Published var toastQueue: [RAToastModel] = []
    @Published var animatingToasts: [UUID: Bool] = [:]

    private var toastTimers: [UUID: Timer] = [:]

    private init() {}

    func showToast(_ model: RAToastModel) {
        toastQueue.append(model)
        animatingToasts[model.id] = false

        // Animate in after a brief delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.linear(duration: 0.4)) {
                self.animatingToasts[model.id] = true
            }

            // Start individual timer for this toast after animation completes
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.startToastTimer(for: model)
            }
        }
    }

    private func startToastTimer(for toast: RAToastModel) {
        // Cancel existing timer if any
        toastTimers[toast.id]?.invalidate()

        // Create new timer for this specific toast
        let timer = Timer.scheduledTimer(withTimeInterval: toast.duration, repeats: false) { [weak self] _ in
            self?.dismissToast(toast.id)
        }

        toastTimers[toast.id] = timer
    }

    func dismissToast(_ toastId: UUID) {
        // Cancel timer for this toast
        toastTimers[toastId]?.invalidate()
        toastTimers.removeValue(forKey: toastId)

        withAnimation(.linear(duration: 0.4)) {
            animatingToasts[toastId] = false
        }

        // Remove from queue after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.toastQueue.removeAll { $0.id == toastId }
            self.animatingToasts.removeValue(forKey: toastId)
        }
    }

    func dismissAllToasts() {
        // Cancel all timers
        for (_, timer) in toastTimers {
            timer.invalidate()
        }
        toastTimers.removeAll()

        // Dismiss all toasts
        for toast in toastQueue {
            dismissToast(toast.id)
        }
    }
}

// MARK: - RAToastContainer

struct RAToastContainer<Content: View>: View {
    let content: Content
    @ObservedObject private var toastManager = RAToastManager.shared

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            content

            // Toast Overlay - All toasts at same position
            if !toastManager.toastQueue.isEmpty {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(toastManager.toastQueue, id: \.id) { toast in
                            HStack {
                                Spacer()

                                RAToast(
                                    model: toast,
                                    onDismiss: {
                                        toastManager.dismissToast(toast.id)
                                    }
                                )

                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .position(
                                x: geometry.size.width / 2,
                                y: geometry.size.height - 80
                            )
                            .offset(y: (toastManager.animatingToasts[toast.id] == true) ? 0 : geometry.size.height)
                            .opacity((toastManager.animatingToasts[toast.id] == true) ? 1 : 0)
                            .scaleEffect((toastManager.animatingToasts[toast.id] == true) ? 1 : 0.8)
                        }
                    }
                }
                .zIndex(999)
                .allowsHitTesting(true)
            }
        }
    }
}

// MARK: - View Extension

extension View {
    func raToastContainer() -> some View {
        RAToastContainer {
            self
        }
    }
}

// MARK: - Convenience Methods

extension RAToastManager {

    /// Show a simple message toast
    func showMessage(_ message: String, type: RAToastType = .success, duration: TimeInterval = 2.0) {
        let model = RAToastModel(
            type: type,
            message: message,
            duration: duration
        )
        showToast(model)
    }

    /// Show a toast with action button
    func showMessageWithAction(
        _ message: String,
        type: RAToastType = .success,
        actionTitle: String,
        actionHandler: @escaping () -> Void,
        duration: TimeInterval = 4.0
    ) {
        let model = RAToastModel(
            type: type,
            message: message,
            actionTitle: actionTitle,
            actionHandler: actionHandler,
            duration: duration
        )
        showToast(model)
    }
}

// MARK: - Preview

#Preview {
    VStack {
        Button("Show Success Toast") {
            RAToastManager.shared.showMessage("Message copied")
        }
        .padding()

        Button("Show Error Toast") {
            RAToastManager.shared.showMessage("Something went wrong", type: .error)
        }
        .padding()

        Button("Show Toast with Action") {
            RAToastManager.shared.showMessageWithAction(
                "Link copied",
                actionTitle: "UNDO"
            ) {
                print("Undo tapped")
            }
        }
        .padding()

        Button("Show Multiple Toasts") {
            RAToastManager.shared.showMessage("First message")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                RAToastManager.shared.showMessage("Second message", type: .warning)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                RAToastManager.shared.showMessage("Third message", type: .error)
            }
        }
        .padding()

        Spacer()
    }
    .raToastContainer()
} 
