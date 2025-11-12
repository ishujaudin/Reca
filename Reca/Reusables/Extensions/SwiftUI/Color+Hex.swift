//
//  Color+Hex.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension Color {

    init(hex: String) {
        // Remove '#' character if present
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        // Convert hex string to UInt64
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        // Create UIColor from RGB
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(UIColor(red: red, green: green, blue: blue, alpha: 1.0))
    }
}
