//
//  Gradients.swift
//  Reca
//
//  Created by Shuja Chattha on 31/08/2025.
//

import SwiftUI

// MARK: - Gradient Colors

struct GradientColors {
    // Emerald gradients
    static let emeraldDarkToMedium = [Color(hex: "04524E"), Color(hex: "022B29")]
    static let lightToDeepMagenta = [Color(hex: "FD54CB"), Color(hex: "CC00A7")]

    // Add more color arrays here as needed
}

// MARK: - Gradient Functions

struct AppGradients {

    /// Create a linear gradient with optional start and end points
    /// - Parameters:
    ///   - colors: Array of colors for the gradient
    ///   - startPoint: Starting point of gradient (default: .top)
    ///   - endPoint: Ending point of gradient (default: .bottom)
    /// - Returns: LinearGradient
    static func linear(
        colors: [Color],
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom
    ) -> LinearGradient {
        LinearGradient(
            colors: colors,
            startPoint: startPoint,
            endPoint: endPoint
        )
    }

    /// Create a radial gradient with optional center and start radius
    /// - Parameters:
    ///   - colors: Array of colors for the gradient
    ///   - center: Center point of gradient (default: .center)
    ///   - startRadius: Starting radius (default: 0)
    ///   - endRadius: Ending radius (default: 100)
    /// - Returns: RadialGradient
    static func radial(
        colors: [Color],
        center: UnitPoint = .center,
        startRadius: CGFloat = 0,
        endRadius: CGFloat = 100
    ) -> RadialGradient {
        RadialGradient(
            colors: colors,
            center: center,
            startRadius: startRadius,
            endRadius: endRadius
        )
    }
}

// MARK: - Quick Access Gradients

extension AppGradients {

    /// Emerald Dark to Medium - Vertical
    static let emeraldVertical = linear(colors: GradientColors.emeraldDarkToMedium)

    /// Emerald Dark to Medium - Horizontal
    static let lightToDeepMagentaHorozontal = linear(
        colors: GradientColors.lightToDeepMagenta,
        startPoint: .leading,
        endPoint: .trailing
    )

    /// Emerald Dark to Medium - Diagonal
    static let emeraldDiagonal = linear(
        colors: GradientColors.emeraldDarkToMedium,
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
