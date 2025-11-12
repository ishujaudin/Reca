//
//  Theme.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import UIKit

protocol Themeable {

    var primaryButtonColor: UIColor { get }

    var primaryButtonDisabledColor: UIColor { get }

    var disabledButtonColor: UIColor { get }

    var darkButtonColor: UIColor { get }

    var primaryButtonTextColor: UIColor { get }

    var primaryButtonDisabledTextColor: UIColor { get }

    var secondaryButtonColor: UIColor { get }

    var secondaryButtonTextColor: UIColor { get }

    var tertiaryButtonColor: UIColor { get }

    var tertiaryButtonTextColor: UIColor { get }

    var dottedButtonColor: UIColor { get }

    var dottedButtonTextColor: UIColor { get }

    var primaryTextColor: UIColor { get }

    var primaryTextColorV2: UIColor { get }

    var primaryTextColorV3: UIColor { get }

    var primaryTextColorV4: UIColor { get }

    var primaryOnboardingTextColor: UIColor { get }

    var primaryBackgroundColor: UIColor { get }

    var secondaryBackgroundColor: UIColor { get }

    var secondaryBackgroundColorV2: UIColor { get }

    var thirdBackgroundColor: UIColor { get }

    var lightBackgroundColor: UIColor { get }

    var darkBackgroundColor: UIColor { get }

    var primaryOnboardingBackgroundColor: UIColor { get }

    var secondaryOnboardingBackgroundColor: UIColor { get }

    var secondaryTextColor: UIColor { get }

    var tertiaryTextColor: UIColor { get }

    var darkTextColor: UIColor { get }

    var lightTextColor: UIColor { get }

    var darkGreyTextColor: UIColor { get }

    var lightGreyTextColor: UIColor { get }

    var placeholderTextColor: UIColor { get }

    var bluePlaceholderTextColor: UIColor { get }

    var greenTextColor: UIColor { get }

    var footnoteTextColor: UIColor { get }

    var errorColor: UIColor { get }

    var dividerColor: UIColor { get }

    var primaryBorderColor: UIColor { get }

    var lightGreyBorderColor: UIColor { get }

    var bannerBackgroundColor: UIColor { get }

    var navigationBarDividerColor: UIColor { get }

    var tabbarBackgroundColor: UIColor { get }

    var tabbarSelectedIconColor: UIColor { get }

    var tabbarUnselectedIconColor: UIColor { get }

    var tabbarDividerColor: UIColor { get }

    var navigationBarBackgroundColor: UIColor { get }

    var navigationBarTintColor: UIColor { get }

    var navigationBarTextColor: UIColor { get }

    var infoBackgroundColor: UIColor { get }

    var infoBorderColor: UIColor { get }

    var premiumCardPrimaryColor: UIColor { get }

    var premiumCardSecondaryColor: UIColor { get }

    var shadow: UIColor { get }

    var pieChartHoleColor: UIColor { get }

    var dropDownDarkColor: UIColor { get }

    var statusBarStyle: UIStatusBarStyle { get }

    var subdetailTextColor: UIColor { get }

    var deepInfoTextColor: UIColor { get }

    var preferencesColor: UIColor { get }

    var disabledOptionColor: UIColor { get }

    var selectedSegmentTextColor: UIColor { get }

    var unselectedSegmentTextColor: UIColor { get }

    var selectedTabPageIndicatorColor: UIColor { get }

    var unselectedTabPageIndicatorColor: UIColor { get }

    var segmentBackgroundColor: UIColor { get }

    var toggleTintColor: UIColor { get }

    var classicCardTextColor: UIColor { get }

    var platinumCardTextColor: UIColor { get }

    var primaryExpandableBottomSheetCapsuleColor: UIColor { get }

    var secondaryExpandableBottomSheetCapsuleColor: UIColor { get }

    var earnBenefitsBackgroundColor: UIColor { get }

    var searchBarBackgroundColor: UIColor { get }

    var flexiPendingAmountsBarBackgroundColor: UIColor { get }

    var iconPrimaryBackgroundColor: UIColor { get }

    var iconSecondaryBackgroundColor: UIColor { get }

    var iconPrimaryColor: UIColor { get }

    var iconSecondaryColor: UIColor { get }

    var iconThirdColor: UIColor { get }

    var iconFourthColor: UIColor { get }

    var iconGreyColor: UIColor { get }
}

extension Themeable {

    var primaryButtonColor: UIColor {
        UIColor(resource: .gold)
    }

    var primaryButtonDisabledColor: UIColor {
        UIColor(resource: .disabledGreen)
    }

    var secondaryButtonColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var tertiaryButtonColor: UIColor {
        UIColor(resource: .softPink)
    }

    var tertiaryButtonTextColor: UIColor {
        UIColor(resource: .deepMagenta)
    }

    var dottedButtonColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var dottedButtonTextColor: UIColor {
        .white
    }

    var disabledButtonColor: UIColor {
        UIColor(resource: .disabledGreen)
    }

    var darkButtonColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var primaryButtonTextColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var primaryButtonDisabledTextColor: UIColor {
        UIColor(resource: .mutedGray)
    }

    var secondaryButtonTextColor: UIColor {
        UIColor(hex: 737373)
    }

    var primaryTextColor: UIColor {
        .white
    }

    var primaryTextColorV2: UIColor {
        .white
    }

    var primaryTextColorV3: UIColor {
        .white
    }

    var primaryTextColorV4: UIColor {
        .white
    }

    var primaryOnboardingTextColor: UIColor {
        .white
    }

    var secondaryTextColor: UIColor {
        UIColor(resource: .gray)
    }

    var tertiaryTextColor: UIColor {
        UIColor(resource: .deepMagenta)
    }

    var darkTextColor: UIColor {
        .white
    }

    var lightTextColor: UIColor {
        .white
    }

    var coolDarkGreyTextColor: UIColor {
        UIColor(resource: .gray)
    }

    var darkGreyTextColor: UIColor {
        UIColor(resource: .gray)
    }

    var darkSlateGreyTextColor: UIColor {
        UIColor(resource: .mutedGray)
    }

    var darkSlateBlueGreyTextColor: UIColor {
        UIColor(resource: .mutedGray)
    }

    var lightGreyTextColor: UIColor {
        UIColor(resource: .gray)
    }

    var placeholderTextColor: UIColor {
        UIColor(resource: .mutedGray)
    }

    var bluePlaceholderTextColor: UIColor {
        UIColor(resource: .gold)
    }

    var greenTextColor: UIColor {
        UIColor(resource: .gold)
    }

    var footnoteTextColor: UIColor {
        UIColor(resource: .mutedGray)
    }

    var primaryBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var secondaryBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var secondaryBackgroundColorV2: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var thirdBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var lightBackgroundColor: UIColor {
        .white
    }

    var darkBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var errorColor: UIColor {
        UIColor(resource: .error)
    }

    var confirmColor: UIColor {
        UIColor(resource: .green)
    }

    var dividerColor: UIColor {
        UIColor(resource: .transparentWhite)
    }

    var lightGreyBorderColor: UIColor {
        UIColor(resource: .transparentWhite)
    }

    var primaryBorderColor: UIColor {
        UIColor(resource: .gold)
    }

    var secondaryBorderColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var infoBackgroundColor: UIColor {
        UIColor(resource: .infoBackground)
    }

    var infoBorderColor: UIColor {
        UIColor(resource: .infoBorder)
    }

    var premiumCardPrimaryColor: UIColor {
        .gradientColorPlatinumDark
    }

    var premiumCardSecondaryColor: UIColor {
        .gradientColorPlatinumLight
    }

    var shadow: UIColor {
        UIColor(resource: .shadow)
    }

    var exchangeCardBorderColor: UIColor {
        .coreColorPrimary40
    }

    var bannerBackgroundColor: UIColor {
        UIColor(resource: .gold)
    }

    var pieChartHoleColor: UIColor {
        .white
    }

    var dropDownDarkColor: UIColor {
        UIColor(resource: .dropDownDark)
    }

    var subdetailTextColor: UIColor {
        .neutralColorMidtone
    }

    var deepInfoTextColor: UIColor {
        UIColor(resource: .deepInfoText)
    }

    var preferencesColor: UIColor {
        UIColor(resource: .gold)
    }

    var sectiontitleTextColor: UIColor {
        UIColor(resource: .gray)
    }

    var disabledOptionColor: UIColor {
        UIColor(resource: .disabledOption)
    }

    var selectedSegmentTextColor: UIColor {
        .black
    }

    var segmentBackgroundColor: UIColor {
        UIColor(resource: .darkGrey)
    }

    var unselectedSegmentTextColor: UIColor {
        UIColor(resource: .lightGrey)
    }
    
    var selectedTabPageIndicatorColor: UIColor {
        UIColor(resource: .gold)
    }

    var unselectedTabPageIndicatorColor: UIColor {
        UIColor(resource: .lightGrey)
    }

    var toggleTintColor: UIColor {
        UIColor(resource: .toggleTint)
    }

    var classicCardTextColor: UIColor {
        .mediumBlue110
    }

    var platinumCardTextColor: UIColor {
        .white
    }

    var primaryExpandableBottomSheetCapsuleColor: UIColor {
        .neutralColorHighlight
    }

    var secondaryExpandableBottomSheetCapsuleColor: UIColor {
        .mediumBlue
    }

    var earnBenefitsBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var searchBarBackgroundColor: UIColor {
        UIColor(resource: .searchBarBackground)
    }

    var pfmTabHeaderTextColor: UIColor {
        .neutralColorLabelDarkGrey
    }

    var flexiPendingAmountsBarBackgroundColor: UIColor {
        UIColor(resource: .flexiPendingAmountsBarBackground)
    }

    var flexiAmountsBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var appThemeColor: UIColor {
        UIColor(resource: .gold)
    }

    var iconPrimaryBackgroundColor: UIColor {
        .white
    }

    var iconSecondaryBackgroundColor: UIColor {
        .white
    }

    var iconPrimaryColor: UIColor {
        UIColor(resource: .gold)
    }

    var iconSecondaryColor: UIColor {
        .white
    }

    var iconThirdColor: UIColor {
        UIColor(resource: .gray)
    }

    var iconFourthColor: UIColor {
        UIColor(resource: .mutedGray)
    }

    var iconGreyColor: UIColor {
        UIColor(resource: .gray)
    }
}

final class LaunchTheme: Themeable {

    var navigationBarDividerColor: UIColor {
        UIColor(resource: .navigationBarDivider)
    }

    var tabbarBackgroundColor: UIColor {
        UIColor(resource: .barBackground)
    }

    var tabbarSelectedIconColor: UIColor {
        UIColor(resource: .gold)
    }

    var tabbarUnselectedIconColor: UIColor {
        UIColor(resource: .gray)
    }

    var tabbarDividerColor: UIColor {
        UIColor(resource: .transparentWhite)
    }

    var navigationBarTintColor: UIColor {
        UIColor(resource: .gold)
    }

    var navigationBarTextColor: UIColor {
        .white
    }

    var navigationBarBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var primaryBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var statusBarStyle: UIStatusBarStyle {
        UITraitCollection.current.userInterfaceStyle == .dark ? .darkContent : .lightContent
    }

    var primaryOnboardingBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }

    var secondaryOnboardingBackgroundColor: UIColor {
        UIColor(resource: .darkIndigo)
    }
}
