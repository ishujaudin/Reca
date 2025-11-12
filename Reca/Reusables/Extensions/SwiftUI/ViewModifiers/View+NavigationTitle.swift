//
//  View+NavigationTitle.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func raNavigationTitle(_ text: String) -> some View {
        modifier(NavigationTitleModifier(text: text))
    }
}

struct NavigationTitleModifier: ViewModifier {
    let text: String

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    titleView
                }
            }
    }

    private var titleView: some View {
        Text(text)
            .font(RAFont.semiBold.with(FontSize.body))
            .foregroundColor(Global.theme.navigationBarTextColor.color)
    }
}
