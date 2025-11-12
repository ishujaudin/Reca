//
//  View+OverflowContentViewModifier.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func scrollOnOverflow() -> some View {
        modifier(OverflowContentViewModifier(view: eraseToAnyView()))
    }
}

private struct OverflowContentViewModifier: ViewModifier {

    @State private var fitInScreen = true

    let view: AnyView

    func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            GeometryReader { geometry in
                content
                    .background(
                        GeometryReader { contentGeometry in
                            Color.clear.preference(key: ViewHeightKey.self,
                                                   value: contentGeometry.frame(in: .local).size.height)
                            .onPreferenceChange(ViewHeightKey.self) {
                                self.fitInScreen = $0 <= geometry.size.height
                            }
                        }
                    )
                    .wrappedInScrollView(when: !fitInScreen)
            }
        } else {
            content
                .coverScreenWithScrollView()
        }
    }
}

private struct ViewHeightKey: PreferenceKey {

    static let defaultValue: CGFloat = 0

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
