//
//  EditingSettingsModel.swift
//  myWeather
//
//  Created by Миша on 07.08.2022.
//

import Foundation

struct EditingSettingsModel {
    
    var settingName: String
    var station = true
    var stateOnTitle: String
    var stateOffTitle: String
    
    static let settings: [EditingSettingsModel] = [
        EditingSettingsModel(settingName: "Temp", stateOnTitle: "C", stateOffTitle: "F"),
        EditingSettingsModel(settingName: "Wind speed", stateOnTitle: "Km", stateOffTitle: "Mi"),
        EditingSettingsModel(settingName: "Time format", stateOnTitle: "12", stateOffTitle: "24"),
        EditingSettingsModel(settingName: "Notifications", stateOnTitle: "On", stateOffTitle: "Off"),
    ]
}
