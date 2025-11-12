//
//  View+Divider.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func raDivider(isHidden: Bool = false,
                    position: RADividerPosition = .bottom,
                    leadingPadding: CGFloat = .zero,
                    trailingPadding: CGFloat = .zero,
                    opacity: RADividerOpacity = .high) -> some View {
        modifier(DividerModifier(view: eraseToAnyView(),
                                 isHidden: isHidden,
                                 position: position,
                                 leadingPadding: leadingPadding,
                                 trailingPadding: trailingPadding,
                                 opacity: opacity))
    }
}

enum RADividerPosition {

    case top
    case bottom
    case both
}

enum RADividerOpacity: Double {

    case low = 0.2
    case mid = 0.5
    case high = 1.0
}

private struct DividerModifier: ViewModifier {

    let view: AnyView
    let isHidden: Bool
    let position: RADividerPosition
    let leadingPadding: CGFloat
    let trailingPadding: CGFloat
    let opacity: RADividerOpacity

    private var divider: some View {
        Divider()
            .background(Global.theme.dividerColor.color)
            .opacity(opacity.rawValue)
            .padding(.leading, leadingPadding)
            .padding(.trailing, trailingPadding)
    }

    func body(content: Content) -> some View {
        // TODO: iOS 13 fix
        if isHidden {
            view
        } else {
            VStack(spacing: .zero) {
                switch position {
                case .top:
                    divider
                    view
                case .bottom:
                    view
                    divider
                case .both:
                    divider
                    view
                    divider
                }
            }
        }
    }
}
