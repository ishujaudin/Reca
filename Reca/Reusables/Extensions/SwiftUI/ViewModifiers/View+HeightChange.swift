//
//  View+HeightChange.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

private struct ViewHeightKey: PreferenceKey {

    static let defaultValue: CGFloat = 0

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

extension View {

    func notifyHeightChange(_ height: Binding<CGFloat>) -> some View {
        modifier(HeightModifier(height: height))
    }
}

private struct HeightModifier: ViewModifier {

    @Binding var height: CGFloat

    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear.preference(key: ViewHeightKey.self,
                                       value: geometry.size.height)
            })
            .onPreferenceChange(ViewHeightKey.self) { value in
                DispatchQueue.main.async {
                    if value > self.height {
                        self.height = value
                    }
                }
            }
    }
}
