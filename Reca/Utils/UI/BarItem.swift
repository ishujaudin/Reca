//
//  BarItem.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI
import UIKit

enum BarItem {

    private enum Size {

        static let `default` = CGSize(width: 24, height: 24)
        static let logo = CGSize(width: 74, height: 28)
    }

    case none
    case back
    case logout
    case cancel
    case dismiss
    case signUp
    case logo
    case profile
    case filter(Bool)
    case chat
    case notifications

    var imageName: String? {
        switch self {
        case .back:
            return "ic_arrow_left"
        case .dismiss:
            return "icNavigationClose"
        case .logo:
            // TODO: Update when large size dark logo is imported
            return "icBarButtonSizeLogoDark"
        case .profile:
            return "ic_profile"
        case .filter(let isFiltered):
            return isFiltered ? "ic_tab_filtered" : "ic_tab_filter"
        case .chat:
            return "ic_chat"
        case .notifications:
            return "ic_navigation_notification"
        default:
            return nil
        }
    }

    var title: String? {
        switch self {
        case .logout:
            return "Logout"
        case .cancel:
            return "Cancel"
        case .signUp:
            return "Sign Up"
        default:
            return nil
        }
    }

    var color: UIColor? {
        switch self {
        case .logo, .filter, .notifications:
            return nil
        case .signUp:
            return Global.theme.primaryButtonColor
        default:
            return Global.theme.navigationBarTintColor
        }
    }

    var font: RAFont { .regular }

    var fontSize: CGFloat { FontSize.body }

    var size: CGSize {
        switch self {
        case .logo:
            return Size.logo
        default:
            return Size.default
        }
    }

    var isBack: Bool {
        switch self {
        case .back:
            return true
        default:
            return false
        }
    }
}
