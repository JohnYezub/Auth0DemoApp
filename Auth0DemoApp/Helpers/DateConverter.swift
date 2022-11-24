//
//  DateConverter.swift
//  Auth0DemoApp
//
//  Created by Yevgeny Yezub on 24/11/22.
//

import Foundation

enum DateMask: String {
    /// dd MMMM YYYY
    case userLongDate = "dd MMMM YYYY"
    /// dd.MM.yyyy
    case userDayMonthYear = "dd.MM.yyyy"
    /// dd.MM
    case userDayMonth = "dd.MM"
    /// dd MMM
    case userDayMonth2 = "dd MMM"
    /// dd MMMM, HH:mm
    case userDateTime = "dd.MM.yyyy HH:mm"
    /// HH:mm
    case userTime = "HH:mm"
    /// "LLLL yyyy"
    case userMonthYear = "LLLL yyyy"
    /// dd MMM HH:mm
    case userDayMonthTime = "dd MMM HH:mm"
    /// yyyy-MM-dd HH:mm:ss
    case APIDateTime = "yyyy-MM-dd HH:mm:ss"
    /// yyyy-MM-dd
    case APIDate = "yyyy-MM-dd"
    /// yyyy-MM-dd'T'HH:mm:ssZ
    case APIDateTimeLocale = "yyyy-MM-dd'T'HH:mm:ssZ"
    var mask: String {
        return self.rawValue
    }
}

class DateConverter {
    static var locale: Locale {
        if let code = Locale.autoupdatingCurrent.languageCode {
            return Locale(identifier: code)
        } else {
            return Locale(identifier: "en_US_POSIX")
        }
    }

    static func dateToString(_ date: Date, dateMask: DateMask) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateMask.mask
        dateFormatter.timeZone = .current
        dateFormatter.calendar = .init(identifier: .gregorian)
        return dateFormatter.string(from: date)
    }

    /// Converts ISO8601 string aka "yyyy-MM-dd'T'HH:mm:ssZ" to Date
    static func convertISO8601(string: String) -> Date? {
        if #available(iOS 10.0, *) {
            return ISO8601DateFormatter().date(from: string)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = locale
            dateFormatter.timeZone = .current
            dateFormatter.calendar = .init(identifier: .gregorian)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter.date(from: string)
        }
    }
}
