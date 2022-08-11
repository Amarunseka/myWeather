//
//  DateExtension.swift
//  myWeather
//
//  Created by Миша on 11.08.2022.
//

import Foundation

enum DateType: String {
    case fullDate = "HH:MM,  EE d MMMM"
    case shortDate = "dd/MM"
    case shortAndWDDate = "EE dd/MM"
    case time = "HH:mm"
}

extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    func toString(type: DateType) -> String {
        Self.formatter.dateFormat = type.rawValue
        return Self.formatter.string(from: self)
    }
}

extension String {
    
    func toDate() -> Date {
        Date.formatter.dateFormat = "yyyy-MM-dd"
        return Date.formatter.date(from: self) ?? Date()

    }
}

extension Int {
    func toDate() -> Date {
        NSDate(timeIntervalSince1970: Double(self)) as Date
    }
}
