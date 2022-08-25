//
//  SettingsTableViewModel.swift
//  myWeather
//
//  Created by Миша on 07.08.2022.
//

import Foundation

struct SettingsTableViewModel {
    
    var settingName: String
    var stateOnTitle: String
    var stateOffTitle: String
    
    static let settings: [SettingsTableViewModel] = [
        SettingsTableViewModel(settingName: "Temp", stateOnTitle: "C", stateOffTitle: "F"),
        SettingsTableViewModel(settingName: "Wind speed", stateOnTitle: "Km", stateOffTitle: "Mi"),
        SettingsTableViewModel(settingName: "Time format", stateOnTitle: "12", stateOffTitle: "24"),
        SettingsTableViewModel(settingName: "Notifications", stateOnTitle: "On", stateOffTitle: "Off"),
    ]
}
