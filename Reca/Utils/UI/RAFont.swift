//
//  RAFont.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation
import SwiftUI
import UIKit

enum RAFont {
    case regular
    case medium
    case mediumItalic
    case semiBold
    case semiBoldItalic
    case bold
    case boldItalic
    case extraBold
    case extraBoldItalic
    case extraLight
    case extraLightItalic
    case light
    case lightItalic
    case italic

    var fontName: String {
        switch self {
        case .regular:
            return "PlusJakartaSans-Regular"
        case .medium:
            return "PlusJakartaSans-Medium"
        case .mediumItalic:
            return "PlusJakartaSans-MediumItalic"
        case .semiBold:
            return "PlusJakartaSans-SemiBold"
        case .semiBoldItalic:
            return "PlusJakartaSans-SemiBoldItalic"
        case .bold:
            return "PlusJakartaSans-Bold"
        case .boldItalic:
            return "PlusJakartaSans-BoldItalic"
        case .extraBold:
            return "PlusJakartaSans-ExtraBold"
        case .extraBoldItalic:
            return "PlusJakartaSans-ExtraBoldItalic"
        case .extraLight:
            return "PlusJakartaSans-ExtraLight"
        case .extraLightItalic:
            return "PlusJakartaSans-ExtraLightItalic"
        case .light:
            return "PlusJakartaSans-Light"
        case .lightItalic:
            return "PlusJakartaSans-LightItalic"
        case .italic:
            return "PlusJakartaSans-Italic"
        }
    }

    var value: UIFont {
        with()
    }

    func with(_ size: CGFloat = FontSize.body) -> UIFont {
        UIFont(name: fontName, size: size)!
    }

    func with(_ size: CGFloat = FontSize.body) -> Font {
        Font.custom(fontName, size: size)
    }
}
