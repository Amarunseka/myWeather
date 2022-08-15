//
//  EditingSettingsModel.swift
//  myWeather
//
//  Created by Миша on 07.08.2022.
//

import Foundation

struct SettingsViewModel {
    
    var settingName: String
    var stateOnTitle: String
    var stateOffTitle: String
    
    static let settings: [SettingsViewModel] = [
        SettingsViewModel(settingName: "Temp", stateOnTitle: "C", stateOffTitle: "F"),
        SettingsViewModel(settingName: "Wind speed", stateOnTitle: "Km", stateOffTitle: "Mi"),
        SettingsViewModel(settingName: "Time format", stateOnTitle: "12", stateOffTitle: "24"),
        SettingsViewModel(settingName: "Notifications", stateOnTitle: "On", stateOffTitle: "Off"),
    ]
}
