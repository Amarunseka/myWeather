//
//  StringExtension.swift
//  myWeather
//
//  Created by Миша on 12.08.2022.
//

import Foundation

extension String {
    /// Замена паттерна строкой.
    /// - Parameters:
    ///   - pattern: Regex pattern.
    ///   - replacement: Строка, на что заменить паттерн.
    func replace(_ pattern: String, replacement: String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        return regex.stringByReplacingMatches(in: self,
                                              options: [.withTransparentBounds],
                                              range: NSRange(location: 0, length: self.count),
                                              withTemplate: replacement)
    }
    
    func convertCityLocation() -> String {
        let location = self.split(separator: ",")
        guard !location.isEmpty else {return ""}
        let city = location[1]
        let country = location[0]
        return "\(city), \(country)"
    }
}
