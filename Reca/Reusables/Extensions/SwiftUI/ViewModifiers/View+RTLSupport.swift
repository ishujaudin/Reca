//
//  View+RTLSupport.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func supportRTL(isArabic: Bool) -> some View {
        modifier(RTLSupportModifier(isArabic: isArabic))
    }
}

private struct RTLSupportModifier: ViewModifier {

    let isArabic: Bool

    func body(content: Content) -> some View {
        content
            .frame(
                maxWidth: .infinity,
                alignment: isArabic ? .trailing : .leading
            )
            .multilineTextAlignment(isArabic ? .trailing : .leading)
    }
}
