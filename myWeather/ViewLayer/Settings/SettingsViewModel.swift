//
//  SettingsViewModel.swift
//  myWeather
//
//  Created by Миша on 23.08.2022.
//

import Foundation

class SettingsViewModel {
    // MARK: - Initial properties
    private var settings = UserDefaultsManager.shared.settings

    // MARK: - Life cycle

    // MARK: - Private methods

    // MARK: - Public methods
    public func changeSettingState(_ notification: NSNotification){
        guard let data = notification.userInfo?["setting"] as? [String: Int],
              let state = data["state"] else {return}

        switch data["index"] {
        case 0:
            settings.tempMode = state
        case 1:
            settings.windSpeedMode = state
        case 2:
            settings.timeFormatMode = state
        case 3:
            settings.sentNotifications = state
        default:
            print("Element not found")
        }
    }
    
    public func saveSettings(){
        Task {
            do {
                try await UserDefaultsManager.shared.save(key: .settings, model: settings)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    UserDefaultsManager.shared.settings = self.settings
                    NotificationCenter.default.post(name: Notification.Name("addLocation"), object: nil)
                }
            }
        }
    }
}
