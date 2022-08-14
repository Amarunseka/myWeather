//
//  UserDefaultsManager.swift
//  myWeather
//
//  Created by Миша on 12.08.2022.
//

import Foundation

enum CurentPresentation {
    case temp
    case wind
    case time
    
    
}

class UserDefaultsManager {
    private lazy var defaults = UserDefaults.standard
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
    
    static let shared: UserDefaultsManager = .init()
    
    var settings: [String: SettingsModel] = ["settings" : SettingsModel()]
    
    func saveSettings(_ data: SettingsModel) {
        self.settings["settings"] = data
        save()
    }
    
    
    private func save(){
        
        do {
            let data = try encoder.encode(settings)
            defaults.setValue(data, forKey: "settings")
        }
        catch {
            print("Coding error", error)
        }
    }
    
    private init() {
        guard let data = defaults.data(forKey: "settings") else {
            return
        }
        do {
            settings = try decoder.decode([String: SettingsModel].self, from: data)
        }
        catch {
            print("Coding error", error)
        }
    }
}
