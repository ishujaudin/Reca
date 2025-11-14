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

    case kuunariBold
    case sfProBlackItalic
    case sfProBold
    case sfProHeavyItalic
    case sfProLightItalic
    case sfProMedium
    case sfProRegular
    case sfProSemiBoldItalic
    case sfProThinItalic
    case sfProUltraLightItalic

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
        case .kuunariBold:
            return "kuunari-bold"
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
        case .sfProBlackItalic:
            return "SFPRODISPLAYBLACKITALIC"
        case .sfProBold:
            return "SFPRODISPLAYBOLD"
        case .sfProHeavyItalic:
            return "SFPRODISPLAYHEAVYITALIC"
        case .sfProLightItalic:
            return "SFPRODISPLAYLIGHTITALIC"
        case .sfProMedium:
            return "SFPRODISPLAYMEDIUM"
        case .sfProRegular:
            return "SFPRODISPLAYREGULAR"
        case .sfProSemiBoldItalic:
            return "SFPRODISPLAYSEMIBOLDITALIC"
        case .sfProThinItalic:
            return "SFPRODISPLAYTHINITALIC"
        case .sfProUltraLightItalic:
            return "SFPRODISPLAYULTRALIGHTITALIC"
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
