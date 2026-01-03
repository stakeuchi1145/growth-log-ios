//
//  DateHelper.swift
//  growth-log-ios
//
//  Created by shin takeuchi on 2026/01/02.
//

import Foundation

final class DateHelper {
    static func toDay(date: Date, format:String = "M/d") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = .current
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    static func toTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = .current
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: Date())
    }

    static func convertDate(date: String) -> Date {
        guard !date.isEmpty else { return Date() }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.date(from: date) ?? Date()
    }
    
    static func startOfDay(date: Date = Date(), calendar: Calendar = .current) -> Date {
        calendar.startOfDay(for: date)
    }
}
