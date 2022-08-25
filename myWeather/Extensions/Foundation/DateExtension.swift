//
//  DateExtension.swift
//  myWeather
//
//  Created by Миша on 11.08.2022.
//

import Foundation

enum DateType: String {
    case fullDate = "HH:mm,  EE d MMMM"
    case shortDate = "dd/MM"
    case shortAndWDDate = "EE dd/MM"
    case time = "HH:mm"
    case hour = "H"
}

extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    func toString(type: DateType) -> String {
        let settings = UserDefaultsManager.shared.settings
        
        if settings.timeFormatMode == 0 {
            var format = ""
            switch type {
            case .fullDate:
                format = "hh:mm a,  EE d MMMM"
            case .time:
                format = "hh:mm a"
            case .hour:
                format = "h a"
            default:
                format = type.rawValue
            }
            Self.formatter.dateFormat = format
        } else {
            Self.formatter.dateFormat = type.rawValue
        }
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
