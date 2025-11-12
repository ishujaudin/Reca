//
//  String+Additions.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation
import UIKit

extension String {
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    mutating func trim() {
        self = self.trimmed
    }

    var toDouble: Double {
        return Double(self) ?? 0.0
    }

    /// Replaces two given string
    ///
    /// - Parameters:
    ///   - target: String to be replaced.
    ///   - withString: Replacement string.
    /// - Returns: replaced string.
    func replace(target: String, withString: String) -> String {
        replacingOccurrences(
            of: target,
            with: withString,
            options: .literal,
            range: nil
        )
    }

    /// Attempts to create a URL instance from the string.
    ///
    /// - Returns: A URL instance if the string represents a valid URL, otherwise nil.
    func asURL() -> URL? {
        return URL(string: self)
    }

    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
}


// MARK: - Validation

extension String {

    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

    /// Regex restricts to 8 character minimum, 1 capital letter, 1 lowercase letter, 1 number
    var isValidPassword: Bool {
        let passwordFormat = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }

    var isValidPasswordCount: Bool { self.count >= 7 }

    var isValidPhoneNumber: Bool {
        let phoneNumberFormat = "^\\+\\d{1,3}\\d{6,14}$"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberFormat)
        return numberPredicate.evaluate(with: self)
    }

    var isValidURL: Bool {
        guard let url = URL(string: self) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    var isNotBlank: Bool {
        return self.trimmed.isNotEmpty
    }
}
