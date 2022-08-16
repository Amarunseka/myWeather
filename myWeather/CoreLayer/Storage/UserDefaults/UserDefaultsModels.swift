//
//  UserDefaultsModels.swift
//  myWeather
//
//  Created by Миша on 12.08.2022.
//

import Foundation

protocol UserDefaultsModelsProtocol {
    
}

struct SettingsModel: UserDefaultsModelsProtocol, Codable {
    var tempMode: Int = 0
    var windSpeedMode: Int = 0
    var timeFormatMode: Int = 1
    var sentNotifications: Int = 1
}

struct CityCoordinatesModel: Codable {
    var location: String = ""
    var latitude: String = ""
    var longitude: String = ""
}
