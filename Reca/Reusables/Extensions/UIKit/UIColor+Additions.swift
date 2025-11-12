//
//  UIColor+Additions.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import UIKit

// swiftlint:disable all

extension UIColor {

    @nonobjc class var coreColorCerulean100: UIColor {
        return UIColor(red: 97.0 / 255.0, green: 183.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var coreColorPrimary100: UIColor {
        return UIColor(red: 5.0 / 255.0, green: 108.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var coreColorPrimary70: UIColor {
        return UIColor(red: 59.0 / 255.0, green: 120.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var coreColorPrimary40: UIColor {
        return UIColor(red: 156.0 / 255.0, green: 186.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var coreColorPrimary50: UIColor {
        return UIColor(red: 229.0 / 255.0, green: 237.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var coreColorPrimary10: UIColor {
        return UIColor(red: 228.0 / 255.0, green: 236.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var coreColorCerulean40: UIColor {
        return UIColor(red: 192.0 / 255.0, green: 226.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var coreColorCerulean10: UIColor {
        return UIColor(red: 239.0 / 255.0, green: 248.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var coreColorSilver: UIColor {
        return UIColor(white: 178.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var coreColorPeacock: UIColor {
        return UIColor(red: 7.0 / 255.0, green: 3.0 / 255.0, blue: 140.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var systemColorError: UIColor {
        return UIColor(red: 1.0, green: 87.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var systemColorConfirm: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 217.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var systemColorWarning: UIColor {
        return UIColor(red: 232.0 / 255.0, green: 187.0 / 255.0, blue: 29.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var systemColorIncomeDark: UIColor {
        return UIColor(red: 15.0 / 255.0, green: 169.0 / 255.0, blue: 49.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var systemColorSuccess: UIColor {
        return UIColor(red: 23.0 / 255.0, green: 157.0 / 255.0, blue: 37 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorWhite: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorOffWhite: UIColor {
        return UIColor(red: 221.0 / 255.0, green: 221.0 / 255.0, blue: 221 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorBackground: UIColor {
        return UIColor(white: 245.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorBackgroundV2: UIColor {
        return UIColor(red: 249.0 / 255.0, green: 250.0 / 255.0, blue: 251 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorLightBackground: UIColor {
        return UIColor(white: 250.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorHighlight: UIColor {
        return UIColor(white: 224.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorDivider: UIColor {
        return UIColor(white: 191.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorMidtone: UIColor {
        return UIColor(white: 106.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorSecondary: UIColor {
        return UIColor(hexString: "101010") // Almost black( slightly lighter); Jet Black
    }

    @nonobjc class var neutralColorLabel: UIColor {
        return UIColor(white: 15.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorLabelCoolDarkGray: UIColor {
        return UIColor(hexString: "565353")
    }

    @nonobjc class var neutralColorLabelDarkGrayCharcoal: UIColor {
        return UIColor(red: 97.0 / 255.0, green: 97.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorLabelDarkGrey: UIColor {
        return UIColor(red: 53.0 / 255.0, green: 56.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorLabelDarkSlateGrey: UIColor {
        return UIColor(hexString: "424242") // Graphite Color
    }

    @nonobjc class var neutralColorLabelDarkSlateBlue: UIColor {
        return UIColor(hexString: "35383F") // Dark Slate Blue Color
    }

    @nonobjc class var neutralColorLabelLightGrey: UIColor {
        return UIColor(red: 107.0 / 255.0, green: 114.0 / 255.0, blue: 128 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorBlack: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorBlack20: UIColor {
        return UIColor(white: 0.0, alpha: 0.2)
    }

    @nonobjc class var neutralColorDisabled: UIColor {
        return UIColor(white: 191.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var neutralColorSearch: UIColor {
        return UIColor(red: 241.0 / 255.0, green: 244.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var creulean40: UIColor {
        return UIColor(red: 194.0 / 255.0, green: 229.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var gradientColorPlatinumDark: UIColor {
        return UIColor(red: 35.0 / 255.0, green: 35.0 / 255.0, blue: 44.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var gradientColorPlatinumLight: UIColor {
        return UIColor(red: 70.0 / 255.0, green: 70.0 / 255.0, blue: 83.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var inactiveColorBlue: UIColor {
        return UIColor(red: 74.0 / 255.0, green: 134.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var mediumBlue: UIColor {
        return UIColor(red: 18.0 / 255.0, green: 91.0 / 255.0, blue: 150.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var mediumBlue110: UIColor {
        return UIColor(red: 3.0 / 255.0, green: 78.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var appTheme: UIColor {
        return UIColor(hexString: "FA35A7")
    }

    @nonobjc class var neutralColorGrey: UIColor {
        return UIColor(hexString: "B4B4B4") // 0.867 white
    }
}

// swiftlint:enable all
