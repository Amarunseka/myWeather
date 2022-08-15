//
//  Converter.swift
//  myWeather
//
//  Created by Миша on 12.08.2022.
//

import Foundation

class Converter {
    
    static func convertDegreeScale(_ number: Int) -> Int {
        let number = number
        if let scale = UserDefaultsManager.shared.settings.first?.value,
           scale.tempMode == 1 {
            let far = (Double(number) * 9 / 5) + 32
            return Int(far)
        } else {
            return number
        }
    }
    
    static func convertWindSpeed(_ number: Double) -> String {
        let speed = number * 3.6
        if let wind = UserDefaultsManager.shared.settings.first?.value,
           wind.windSpeedMode == 1 {
            let mlPerH = String(format: "%.1f", (speed / 1.609))
            return "\(mlPerH) ml/h"
        } else {
            let kmPerH = String(format: "%.1f", (speed))
            return "\(kmPerH) km/h"
        }
    }
    
    static func convertUVIndex(_ index: Int?) -> String {
        guard let index = index else {return ""}
        switch index {
        case 0...2:
            return "\(index) (LOW)"
        case 3...5:
            return "\(index) (MIDL)"
        case 6...7:
            return "\(index) (HIGH)"
        case 8...10:
            return "\(index) (VERY HIGH)"
        case 11...12:
            return "\(index) (EXTREME)"
        default:
            return ""
        }
    }
}
