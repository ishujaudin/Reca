//
//  View+OnFirstAppearModifier.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

private struct OnFirstAppearModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)

    /// Lifecycle modifier that only fires when the View appears for the first time.
    /// - Parameter action: Action block that will be executed.
    init(perform action: @escaping (() -> Void)) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action()
            }
        }
    }
}

extension View {

    /// Adds an action to perform when this view appears for the first time.
    /// - Parameter action: The action to perform. If action is nil, the call has no effect.
    /// - Returns: A view that triggers action when this view appears for the first time.
    func onFirstAppear(perform action: @escaping (() -> Void)) -> some View {
        modifier(OnFirstAppearModifier(perform: action))
    }
}
