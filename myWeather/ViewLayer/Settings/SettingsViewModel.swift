//
//  SettingsViewModel.swift
//  myWeather
//
//  Created by Миша on 23.08.2022.
//

import Foundation

class SettingsViewModel {
    // MARK: - Initial properties
    private var settings = UserDefaultsManager.shared.settings.first?.value

    // MARK: - Life cycle

    // MARK: - Private methods

    // MARK: - Public methods
    public func changeSettingState(_ notification: NSNotification){
        guard let data = notification.userInfo?["setting"] as? [String: Int],
              let state = data["state"],
              var setting = settings else {return}

        switch data["index"] {
        case 0:
            setting.tempMode = state
        case 1:
            setting.windSpeedMode = state
        case 2:
            setting.timeFormatMode = state
        case 3:
            setting.sentNotifications = state
        default:
            print("Element not found")
        }
        self.settings = setting
    }
    
    public func saveSettings(){
        guard let data = settings else {return}
        let userDefaults = UserDefaultsManager.shared
        userDefaults.saveSettings(data)
        NotificationCenter.default.post(name: Notification.Name("addLocation"), object: nil)
    }
}
