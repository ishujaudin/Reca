//
//  View+LargeNavigationTitle.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

enum NavigationBarStyle {

    case `default`
    case secondary
}

extension View {

    func largeNavigationTitle(_ title: String,
                              style: NavigationBarStyle = .default,
                              backgroundColor: Color = Global.theme.secondaryBackgroundColor.color,
                              backButtonDestination: Notification.Name? = nil
    ) -> some View {
        modifier(LargeNavigationTitle(
            title: title,
            view: eraseToAnyView(),
            backgroundColor: backgroundColor,
            backButtonDestination: backButtonDestination,
            style: style)
        )
    }
}

private struct LargeNavigationTitle: ViewModifier {

    private enum Constant {

        static let backArrowImageName = "ic_arrow_left"
    }

    let title: String
    let view: AnyView
    let backgroundColor: Color
    let backButtonDestination: Notification.Name?

    var style: NavigationBarStyle

    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        VStack {
            navigationArea
            view
                .navigationBarHidden(true)
        }
    }

    private var navigationArea: some View {
        VStack(alignment: .leading, spacing: Global.Margin.xxxlarge) {
            backBarButton
                .padding(.bottom, Global.Margin.medium)
            titleView
        }
        .padding(.top, Global.Margin.xxxlarge)
        .padding(.horizontal, Global.Margin.medium)
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.top)
    }

    private var backBarButton: some View {
        HStack(spacing: .zero) {
            Image(Constant.backArrowImageName)
                .onTouchDown {
                    if let backButtonDestination = backButtonDestination {
                        navigateToBackButtonDestination(backButtonDestination)
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            Spacer()
        }
        .padding(.top, Global.Margin.xxxlarge)
    }

    private var titleView: some View {
        Text(title)
            .font(RAFont.bold.with(FontSize.title))
            .foregroundColor(Global.theme.primaryTextColor.color)
    }

    private func navigateToBackButtonDestination(_ backButtonDestination: Notification.Name) {
        NotificationCenter.default.post(
            name: backButtonDestination,
            object: nil
        )
    }
}
