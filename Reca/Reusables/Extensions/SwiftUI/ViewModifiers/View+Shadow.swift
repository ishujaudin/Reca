//
//  View+Shadow.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func shadow(type: ShadowType) -> some View {
        modifier(ShadowModifier(type: type))
    }
}

private struct ShadowModifier: ViewModifier {

    let type: ShadowType

    func body(content: Content) -> some View {
        content
            .shadow(color: type.color.color.opacity(Double(type.alpha)),
                    radius: type.blur / 2.0,
                    x: type.x,
                    y: type.y)
    }
}
