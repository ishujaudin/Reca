//
//  RAAlertView.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

// MARK: - Constant

private extension RAAlertView {
    enum Constant {
        static let contentSpacing: CGFloat = Global.Margin.xsmall // 8
        static let contentVerticalPadding: CGFloat = Global.Margin.xlarge // 24
        static let horizontalPadding: CGFloat = Global.Margin.medium // 16
        static let iconBottomPadding: CGFloat = Global.Margin.xsmall // 8
        static let iconSize: CGFloat = 80.0
        static let textContentHorizontalPadding: CGFloat = Global.Margin.medium // 16
        static let buttonsSpacing: CGFloat = Global.Margin.medium // 16
        static let buttonsTopPadding: CGFloat = Global.Margin.xxxxxlarge // 48

        static let cornerRadius: CGFloat = Global.CornerRadius.mediumHigh // 24
        static let buttonCornerRadius: CGFloat = Global.CornerRadius.mid // 8
        static let overlayOpacity: Double = Global.Opacity.low // 0.4
    }
}

// MARK: - CustomAlertView

struct RAAlertView: View {
    enum AlertStyle {
        case `default`, destructive
    }

    let icon: ImageResource?
    let systemIcon: String?
    let iconTintColor: Color?
    let title: String
    let message: String
    let primaryButtonTitle: String
    let primaryButtonStyle: AlertStyle
    let primaryAction: () -> Void
    let secondaryButtonTitle: String?
    let secondaryButtonStyle: AlertStyle?
    let secondaryAction: (() -> Void)?

    @Binding var isPresented: Bool

    init(
        icon: ImageResource? = nil,
        systemIcon: String? = nil,
        iconTintColor: Color? = nil,
        title: String,
        message: String,
        primaryButtonTitle: String,
        primaryButtonStyle: AlertStyle,
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String? = nil,
        secondaryButtonStyle: AlertStyle? = nil,
        secondaryAction: (() -> Void)? = nil,
        isPresented: Binding<Bool>
    ) {
        self.icon = icon
        self.systemIcon = systemIcon
        self.iconTintColor = iconTintColor
        self.title = title
        self.message = message
        self.primaryButtonTitle = primaryButtonTitle
        self.primaryButtonStyle = primaryButtonStyle
        self.primaryAction = primaryAction
        self.secondaryButtonTitle = secondaryButtonTitle
        self.secondaryButtonStyle = secondaryButtonStyle
        self.secondaryAction = secondaryAction
        self._isPresented = isPresented
    }


    var body: some View {
        mainContent
    }

    private var mainContent: some View {
        ZStack {
            backgroundColor
            content
        }
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
    }

}

// MARK: - View Components

private extension RAAlertView {

    var backgroundColor: some View {
        Global.theme.darkBackgroundColor.color
            .opacity(Constant.overlayOpacity)
            .ignoresSafeArea()
    }

    private var content: some View {
        VStack(spacing: Constant.contentSpacing) {
            image
            textContent
            buttonRow
        }
        .padding(.vertical, Constant.contentVerticalPadding)
        .padding(.horizontal, Constant.horizontalPadding)
        .background(Global.theme.lightBackgroundColor.color)
        .cornerRadius(Constant.cornerRadius)
        .padding(.horizontal, Constant.horizontalPadding)
    }

    @ViewBuilder
    var image: some View {
        if let systemIcon {
            Image(systemName: systemIcon)
                .font(.system(size: Constant.iconSize))
                .foregroundColor(iconTintColor ?? .primary)
                .frame(width: Constant.iconSize, height: Constant.iconSize)
                .padding(.bottom, Constant.iconBottomPadding)
        } else if let icon {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: Constant.iconSize, height: Constant.iconSize)
                .foregroundColor(iconTintColor)
                .padding(.bottom, Constant.iconBottomPadding)
        }
    }

    var textContent: some View {
        VStack(spacing: Constant.contentSpacing) {
            titleText
            messageText
        }
        .padding(.horizontal, Constant.textContentHorizontalPadding)
    }

    var titleText: some View {
        Text(title)
            .font(RAFont.semiBold.with(FontSize.title1))
            .multilineTextAlignment(.center)
    }

    var messageText: some View {
        Text(message)
            .font(RAFont.regular.with(FontSize.smallBody))
            .multilineTextAlignment(.center)
    }

    var buttonRow: some View {
        HStack(spacing: Constant.buttonsSpacing) {
            secondaryButton
            primaryButton
        }
        .padding(.top, Constant.buttonsTopPadding)
    }

    @ViewBuilder
    var secondaryButton: some View {
        if let secondaryButtonTitle, let secondaryAction, let secondaryButtonStyle {
            alertButton(title: secondaryButtonTitle, style: secondaryButtonStyle) {
                isPresented = false
                secondaryAction()
            }
        }
    }

    var primaryButton: some View {
        alertButton(title: primaryButtonTitle, style: primaryButtonStyle) {
            isPresented = false
            primaryAction()
        }
    }

    private func alertButton(title: String, style: AlertStyle, action: @escaping () -> Void) -> some View {
        HapticButton(.lightImpact, action: action) {
            Text(title)
                .foregroundColor(Global.theme.lightTextColor.color)
                .font(RAFont.medium.with(FontSize.button))
                .frame(maxWidth: .infinity)
                .frame(height: Global.Height.xxxlarge)
                .background(
                    style == .destructive ?
                    Global.theme.errorColor.color
                    : Global.theme.primaryButtonColor.color
                )
                .cornerRadius(Global.CornerRadius.mid)
        }
    }
}
