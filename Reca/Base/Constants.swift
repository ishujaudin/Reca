//
//  Constants.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import UIKit

enum Global {

    static var theme: Themeable = LaunchTheme() {
        didSet {
            UIApplication.shared.statusBarStyle = theme.statusBarStyle
        }
    }

    enum BundleID: String {

        case dist = "com.reca"
        case `internal` = "com.reca.InternalRelease"
        case debug = "com.reca.development"
    }

    #if DIST_RELEASE
    static let groupID = "group.com.reca"
    #elseif INTERNAL_RELEASE || UAT_RELEASE
    static let groupID = "group.com.reca.InternalRelease"
    #else
    static let groupID = "group.com.reca.development"
    #endif

    enum CornerRadius {

        /// 4
        static let low: CGFloat = 4
        /// 8
        static let mid: CGFloat = 8
        /// 10
        static let midHigh: CGFloat = 10
        /// 12
        static let regular: CGFloat = 12
        /// 16
        static let high: CGFloat = 16
        /// 22
        static let mediumHigh: CGFloat = 22
        /// 30
        static let extraHigh: CGFloat = 30
    }

    enum StrokeWidth {

        /// 1
        static let tiny: CGFloat = 1
        /// 2
        static let small: CGFloat = 2
        /// 3
        static let regular: CGFloat = 3
        /// 5
        static let medium: CGFloat = 5
        /// 8
        static let midHigh: CGFloat = 8
        /// 10
        static let large: CGFloat = 10
    }

    enum LayoutPriorityLevel {

        /// 0
        static let `default`: Double = 0
        /// 1
        static let high: Double = 1
    }

    enum InactivityTime {

        static let notRegistered: TimeInterval = 15 * 60
        static let registered: TimeInterval = 5 * 60
        static var test: TimeInterval?
    }

    enum UserInterface {

        static let animationDuration: TimeInterval = 0.3
        static let margin: CGFloat = 16.0
        static let padding: CGFloat = 8.0
    }

    enum StoryboardName {

        static let auth = "Auth"
        static let banks = "Banks"
        static let card = "Card"
        static let cardWeb = "CardWeb"
        static let forgotPin = "ForgotPin"
        static let login = "Login"
        static let opening = "Opening"
        static let result = "Result"
    }

    enum Margin {

        /// 4
        static let tiny: CGFloat = 4
        /// 8
        static let xsmall: CGFloat = 8
        /// 12
        static let small: CGFloat = 12
        /// 14
        static let smallMedium: CGFloat = 14
        /// 16
        static let medium: CGFloat = 16
        /// 20
        static let large: CGFloat = 20
        /// 24
        static let xlarge: CGFloat = 24
        /// 28
        static let xxlarge: CGFloat = 28
        /// 32
        static let xxxlarge: CGFloat = 32
        /// 40
        static let xxxxlarge: CGFloat = 40
        /// 48
        static let xxxxxlarge: CGFloat = 48
        /// 56
        static let huge: CGFloat = 56
        /// 64
        static let massive: CGFloat = 64
        /// 72
        static let giant: CGFloat = 72
    }

    
    enum Height {

        /// 4
        static let tiny: CGFloat = 4
        /// 8
        static let xsmall: CGFloat = 8
        /// 12
        static let small: CGFloat = 12
        /// 16
        static let medium: CGFloat = 16
        /// 20
        static let large: CGFloat = 20
        /// 24
        static let largeMedium: CGFloat = 24
        /// 30
        static let xlarge: CGFloat = 30
        /// 40
        static let xxlarge: CGFloat = 40
        /// 48
        static let xxxlarge: CGFloat = 48
        /// 56
        static let xxxxlarge: CGFloat = 56
        /// 60
        static let xxxxxlarge: CGFloat = 60
        
    }

    enum AnimationDuration {

        static let fast: TimeInterval = 0.15
        static let normal: TimeInterval = 0.3
        static let slow: TimeInterval = 0.5
        static let mediumSlow: TimeInterval = 0.8
        static let extraSlow: TimeInterval = 1.0
    }

    enum RouteType {

        case push
        case present
        case dismiss
    }

    enum RoutingDelay {

        static let short = 0.3
        static let medium = 0.5
        static let mediumLong = 0.7
        static let long = 1.0
        static let extraLong = 1.5
    }

    enum Opacity {
        static let full = 1.0
        static let medium = 0.6
        static let low = 0.4
        static let veryLow = 0.2
        static let extraLow = 0.1
    }
}
