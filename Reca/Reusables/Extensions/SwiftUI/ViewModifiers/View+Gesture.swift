//
//  View+Gesture.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

enum RAGestureType {
    case `default`
    case simultaneous
}

extension View {
    func onTouchDown(_ type: RAGestureType = .default,
                     perform action: @escaping (() -> Void)) -> some View {
        modifier(RAGestureModifier(type: type, action: action))
    }
}

private struct RAGestureModifier: ViewModifier {
    var type: RAGestureType
    var action: (() -> Void)

    func body(content: Content) -> some View {
        switch type {
        case .`default`:
            background(with: content)
                .gesture(tapGesture)
        case .simultaneous:
            background(with: content)
                .simultaneousGesture(tapGesture)
        }
    }

    private var tapGesture: some Gesture {
        TapGesture()
            .onEnded { _ in
                action()
            }
    }

    private func background(with content: Content) -> some View {
        content
            .contentShape(Rectangle())
    }
}
