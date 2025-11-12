//
//  DateFormatUtility.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

enum DateTimeZone: String {

    case utc = "UTC"
    case current

    var timezone: TimeZone {
        switch self {
        case .utc:
            return TimeZone(abbreviation: self.rawValue) ?? .current
        case .current:
            return .current
        }
    }
}

enum DateFormatType: String {

    /// Default server-side date format.
    /// Eg: 2021-08-30T13:29:17.121204+00:00
    case `default` = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"

    /// i2c servers date format.
    /// Eg: 2021-08-30 13:29:17
    case i2c = "yyyy-MM-dd HH:mm:ss"

    /// Long month and day.
    /// Eg. April 3 for english locale for 3 April 2019 Wednesday date
    case longMonthWithDay = "MMMM d"

    /// Long month.
    /// Eg. April
    case longMonthOnly = "MMMM"

    /// Short day, month, year with slash separator, hour and minute with ":" separator .
    /// Eg. Wednesday 03/04/2019 - 08:00
    case fullNameAndShortDateWithSlashAndTime = "EEEE dd/MM/yyyy - HH:mm"

    /// Short day, month, year with "/" separator .
    /// Eg. 23/04/2019
    case shortDateWithSlash = "dd/MM/yyyy"

    /// Short year, month, day with "-" separator .
    /// 2019-04-23
    case shortDateWithDash = "yyyy-MM-dd"

    /// Short day, month, year with "/" separator, hour and minute with ":" separator.
    /// Eg. 23/04/2019 11:23
    case shortDateWithSlashAndTime = "dd/MM/yyyy HH:mm"

    /// Short month, year with "/" separator .
    /// Eg. 04/2019
    case shortMonthAndYearWithSlash = "MM/yyyy"

    /// Date with short month name
    /// Eg. 10 Jan, 2021
    case dateWithShortMonthName = "d MMM yyyy"

    /// Date with long month name
    /// Eg. January 2021
    case dateWithLongMonthName = "MMMM yyyy"

    /// Date with month only
    /// Eg. 10
    case monthOnly = "MM"

    /// Date with year only
    /// Eg. 2021
    case yearOnly = "yyyy"

    // Short month, year with.
    /// Eg. Aug 2023
    case shortMonthNameAndYear = "MMM yyyy"

    // Short month, year with "-" separator .
    /// Eg. 2023-08
    case shortMonthAndYearWithDash = "yyyy-MM"

    /// Server date format
    /// Eg. 2022-09-10T10:35:42.000
    case secondaryServerDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

    /// Full month, date and year
    /// June 13 2022
    case fullMonthDateYear = "MMMM dd yyyy"

    /// Hour and minutes
    /// 08:37
    case hourAndMinutes = "HH:mm"

    /// Week day name,, moth, date
    /// Eg. Tue, Sep 7
    case dayMonthAbbreviated = "E, MMM d"
    
    /// Short month, day with leading zero, year, 12-hour time with AM/PM
    /// Eg. Mar 11 2023, 11:42 AM
    case shortMonthDayYearWithTime = "MMM dd yyyy, h:mm a"
    
    /// Full date with time and pipe separator  
    /// Eg. 12 May 2025 | 09:00AM
    case fullDateWithTime = "d MMM yyyy '|' HH:mm aa"
}

enum DateFormatUtility {

    private static let dispatchDateFormatterQueue = DispatchQueue(
        label: "dateFormatterQueue",
        qos: .utility)

    private static var dateFormatters: [DateFormatType: DateFormatter] = [:]

    static func dateFormatter(type: DateFormatType) -> DateFormatter {
        let dateFormatter = dispatchDateFormatterQueue.sync {
            dateFormatters[type]
        }

        let formatter: DateFormatter
        if let dateFormatter = dateFormatter {
            formatter = dateFormatter
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = type.rawValue
            dateFormatter.calendar = Calendar(identifier: .gregorian)
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            formatter = dateFormatter
            dateFormatters[type] = dateFormatter
        }

        return formatter
    }

    static func dateFormatterWithTimeZone(
        format: DateFormatType,
        timezone: DateTimeZone
    ) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timezone.timezone
        return dateFormatter
    }
}
