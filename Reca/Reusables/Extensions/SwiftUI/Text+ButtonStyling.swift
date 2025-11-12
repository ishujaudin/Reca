//
//  Text+ButtonStyling.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

private enum Constant {

    static let cornerRadiusForSecondaryButtons: CGFloat = 10.0
    static let cornerRadius: CGFloat = 24.0
    static let height: CGFloat = 48.0
    static let heightLarge: CGFloat = 60.0

    static let dottedBorderLineWidth: CGFloat = 2.0
    static let dottedBorderDash: [CGFloat] = [5]
}

extension View {

    func applyPrimaryButtonStyling(with style: ButtonStyle = .default) -> some View {
        modifier(PrimaryButtonStyle(style: style))
    }

    func applyEmptyButtonStyling(with style: EmptyButtonStyle = .default) -> some View {
        modifier(EmptyButton.DefaultButtonStyle(style: style))
    }

    func applyGreyedEmptyButtonStyling() -> some View {
        modifier(EmptyButton.GreyedButtonStyle())
    }

    func applyLinkButtonStyling(horizontalPading: CGFloat? = nil, foregroundColor: Color = Global.theme.primaryButtonColor.color) -> some View {
        modifier(LinkStyle(horizontalPadding: horizontalPading, foregroundColor: foregroundColor))
    }
}

enum ButtonStyle {

    case `default`
    case secondary
    case tertiary
    case destructive
    case dottedBorder

    var backgroundColor: Color {
        switch self {
        case .default:
            Global.theme.primaryButtonColor.color
        case .secondary:
            Global.theme.secondaryButtonColor.color
        case .tertiary:
            Global.theme.appThemeColor.color
        case .destructive:
            Global.theme.errorColor.color
        case .dottedBorder:
            Global.theme.dottedButtonColor.color
        }
    }

    var textColor: Color {
        switch self {
        case .dottedBorder:
            return Global.theme.dottedButtonTextColor.color
        default:
            return Global.theme.primaryButtonTextColor.color
        }
    }

    var disabledBackgroundColor: Color {
        Global.theme.primaryButtonDisabledColor.color
    }

    var disabledTextColor: Color {
        Global.theme.primaryButtonDisabledTextColor.color
    }

    var cornerRadius: CGFloat {
        Constant.cornerRadius
    }

    var font: Font {
        switch self {
        case .dottedBorder:
            RAFont.semiBold.with(FontSize.button)
        default:
            RAFont.medium.with(FontSize.button)
        }
    }

    var height: CGFloat {
        Constant.height
    }
 
    var maxWidth: CGFloat? {
        switch self {
        case .default, .secondary, .destructive, .dottedBorder:
            return .infinity
        case .tertiary:
            return nil
        }
    }
}

private struct PrimaryButtonStyle: ViewModifier {

    let style: ButtonStyle

    @Environment(\.isEnabled) private var isEnabled

    func body(content: Content) -> some View {
        content
            .foregroundColor(
                isEnabled ?
                style.textColor : style.disabledTextColor
            )
            .font(style.font)
            .frame(maxWidth: style.maxWidth)
            .frame(height: style.height)
            .background(
                isEnabled ?
                style.backgroundColor : style.disabledBackgroundColor
            )
            .cornerRadius(style.cornerRadius)
            .overlay(
                style == .dottedBorder
                ? RoundedRectangle(cornerRadius: style.cornerRadius)
                    .stroke(style: StrokeStyle(lineWidth: Constant.dottedBorderLineWidth, dash: Constant.dottedBorderDash))
                    .foregroundColor(Global.theme.primaryButtonColor.color)
                : nil
            )
    }
}

struct LinkStyle: ViewModifier {

    var horizontalPadding: CGFloat?
    var foregroundColor: Color?
    @Environment(\.isEnabled) private var isEnabled

    func body(content: Content) -> some View {
        content
            .foregroundColor(
                isEnabled ?
                foregroundColor : Global.theme.dividerColor.color
            )
            .font(RAFont.semiBold.with(FontSize.button))
            .padding(.horizontal, horizontalPadding)
            .background(Color.clear)
    }
}

enum EmptyButtonStyle {

    case `default`
    case alert
    case secondary

    var textColor: Color {
        switch self {
        case .alert:
            return Global.theme.errorColor.color
        case .`default`, .secondary:
            return Global.theme.primaryButtonColor.color
        }
    }

    var backgroundColor: Color {
        Global.theme.primaryBackgroundColor.color
    }

    var cornerRadius: CGFloat {
        switch self {
        case .secondary:
            return Constant.cornerRadiusForSecondaryButtons
        default:
            return Constant.cornerRadius
        }
    }

    var font: Font {
        switch self {
        case .secondary:
            return RAFont.bold.with(FontSize.buttonEmpty)
        default:
            return RAFont.semiBold.with(FontSize.button)
        }
    }
}

private enum EmptyButton {

    struct DefaultButtonStyle: ViewModifier {

        let style: EmptyButtonStyle

        @Environment(\.isEnabled) private var isEnabled

        func body(content: Content) -> some View {
            content
                .foregroundColor(
                    isEnabled ?
                    style.textColor :
                        Global.theme.primaryButtonDisabledTextColor.color
                )
                .font(style.font)
                .frame(maxWidth: .infinity)
                .frame(height: Constant.heightLarge)
                .background(
                    isEnabled ?
                    style.backgroundColor :
                        Global.theme.secondaryBackgroundColor.color
                )
                .cornerRadius(style.cornerRadius)
                .overlay(RoundedRectangle(cornerRadius: style.cornerRadius)
                    .stroke(
                        Global.theme.secondaryBorderColor.color
                    ))
        }
    }

    struct GreyedButtonStyle: ViewModifier {

        func body(content: Content) -> some View {
            content
                .foregroundColor(Global.theme.placeholderTextColor.color)
                .font(RAFont.bold.with(FontSize.button))
                .frame(maxWidth: .infinity)
                .frame(height: Constant.height)
                .background(Global.theme.secondaryBackgroundColor.color)
                .cornerRadius(Constant.cornerRadius)
                .overlay(RoundedRectangle(cornerRadius: Constant.cornerRadius)
                            .stroke(Global.theme.placeholderTextColor.color))
        }
    }
}

// MARK: - PreviewProvider

struct ButtonsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Global.Margin.xsmall) {
            Button {
                // Left blank intentionally
            } label: {
                Text("Primary Button Styling")
                    .applyPrimaryButtonStyling()
            }

            Button {
                // Left blank intentionally
            } label: {
                Text("Secondary Button Styling")
                    .applyPrimaryButtonStyling(with: .secondary)
            }

            Button {
                // Left blank intentionally
            } label: {
                Text("Link Button")
                    .applyLinkButtonStyling()
            }

            Button {
                // Left blank intentionally
            } label: {
                Text("Empty Button")
                    .applyEmptyButtonStyling()
            }

            Button {
                // Left blank intentionally
            } label: {
                Text("Empty Greyed Button")
                    .applyGreyedEmptyButtonStyling()
            }

            Button {
                // Left blank intentionally
            } label: {
                Text("Secondary Empty Button")
                    .applyEmptyButtonStyling(with: .secondary)
            }
        }
        .padding()
    }
}
