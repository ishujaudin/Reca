//
//  View+CardAppearance.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func cardAppearance(width: CGFloat = .infinity,
                        cornerRadius: CGFloat = Global.CornerRadius.low,
                        background: Color = Global.theme.primaryBackgroundColor.color) -> some View {
        modifier(CardAppearanceModifier(width: width,
                                        cornerRadius: cornerRadius,
                                        background: background))
    }
}

private struct CardAppearanceModifier: ViewModifier {

    let width: CGFloat
    let cornerRadius: CGFloat
    let background: Color

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: width)
            .background(background)
            .cornerRadius(cornerRadius)
    }
}
