//
//  View+HeaderView.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

enum HeaderViewStyle {

    case `default`
    case primary
    case secondary

    var backgroundColor: Color {
        switch self {
        case .default:
            return Global.theme.navigationBarBackgroundColor.color
        case .primary:
            return Global.theme.primaryBackgroundColor.color
        case .secondary:
            return Global.theme.secondaryBackgroundColor.color
        }
    }

    var foregroundColor: Color {
        switch self {
        case .default:
            return Global.theme.primaryBackgroundColor.color
        case .primary:
            return Global.theme.primaryTextColor.color
        case .secondary:
            return Global.theme.darkGreyTextColor.color
        }
    }
}

extension View {

    func setHeaderView(_ title: String, style: HeaderViewStyle = .default) -> some View {
        modifier(HeaderView(
            title: title,
            view: eraseToAnyView(),
            style: style)
        )
    }
}

private struct HeaderView: ViewModifier {

    private enum Constant {

        static let dismissImage = "icNavigationClose"
        static let dismissImageWidth = 24.0
    }

    let title: String
    let view: AnyView

    var style: HeaderViewStyle

    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        VStack {
            navigationArea
                .background(style.backgroundColor)
            view
                .navigationBarHidden(true)
        }
    }

    private var navigationArea: some View {
        HStack(alignment: .top, spacing: .zero) {
            headerTitle
            Spacer()
            dismissButton
        }
        .padding(Global.Margin.medium)
        .padding(.top, Global.Margin.xsmall)
    }

    private var headerTitle: some View {
        Text(title)
            .font(RAFont.semiBold.with(FontSize.title4))
            .foregroundColor(style.foregroundColor)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    private var dismissButton: some View {
        Image(Constant.dismissImage)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(style.foregroundColor)
            .frame(width: Constant.dismissImageWidth, height: Constant.dismissImageWidth)
            .onTouchDown {
                presentationMode.wrappedValue.dismiss()
            }
    }
}
