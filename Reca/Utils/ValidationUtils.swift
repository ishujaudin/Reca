//
//  ValidationUtils.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

struct ValidationUtils {
    
    static func isValidEmailOrPhone(_ input: String) -> Bool {
        guard input.isNotEmpty else { return false }

        // Check if input is a valid phone number (all digits)
        let isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: input))
        if isNumeric && input.count >= 8 { // Minimum length for phone number validation
            return true
        }

        // Check if input is a valid email
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailPredicate.evaluate(with: input)
    }

    static func isValidPassword(_ password: String) -> Bool {
        // Perform password validation logic here
        return password.count >= 8 // Example: Password should be at least 8 characters long
    }
}
