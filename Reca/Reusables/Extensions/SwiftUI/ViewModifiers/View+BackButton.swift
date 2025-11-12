//
//  View+BackButton.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func setRABackButtonHidden(_ isHidden: Bool, shouldGoBacktoHome: Bool = false) -> some View {
        modifier(RABackButtonHiddenModifier(view: eraseToAnyView(),
                                             isHidden: isHidden,
                                             shouldGoBacktoHome: shouldGoBacktoHome))
    }
}

private struct RABackButtonHiddenModifier: ViewModifier {

    let view: AnyView
    let isHidden: Bool
    let shouldGoBacktoHome: Bool

    @Environment(\.presentationMode) var presentationMode

    private var backBarButton: some View {
        BarButtonItemView(barItem: .back) {
            if shouldGoBacktoHome {
                // TODO: go to home
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    func body(content: Content) -> some View {
        if isHidden {
            view
                .navigationBarBackButtonHidden(true)
                .raNavigationBarLeadingItems(
                    BarButtonItemView(barItem: .none)
                        .eraseToAnyView()
                )
        } else {
            view
                .navigationBarBackButtonHidden(true)
                .raNavigationBarLeadingItems(backBarButton.eraseToAnyView())
        }
    }
}
