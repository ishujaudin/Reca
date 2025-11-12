//
//  Date+Additions.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

extension Date {

    /// Formats the current date or any `Date` instance to a string based on the provided format and timezone.
    /// - Parameters:
    ///   - format: The `DateFormatType` enum case defining the date format.
    ///   - timezone: The `DateTimeZone` enum case defining the timezone.
    /// - Returns: A string representing the date in the provided format and timezone.
    func toString(format: DateFormatType, timezone: DateTimeZone = .current) -> String {
        let formatter = DateFormatUtility.dateFormatterWithTimeZone(format: format, timezone: timezone)
        return formatter.string(from: self)
    }
}
