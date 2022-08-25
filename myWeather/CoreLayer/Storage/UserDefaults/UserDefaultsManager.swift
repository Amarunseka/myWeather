//
//  UserDefaultsManager.swift
//  myWeather
//
//  Created by Миша on 12.08.2022.
//

import Foundation

enum UserDefaultsNames: String, Codable {
    case settings = "settings"
    case cities = "cities"
}

class UserDefaultsManager {

    private lazy var defaults = UserDefaults.standard
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
    
    static let shared: UserDefaultsManager = .init()
    
    var settings: [UserDefaultsNames: SettingsModel] = [.settings : SettingsModel()]
    var cities: [UserDefaultsNames: [CityCoordinatesModel]] = [.cities: []]
    
    
    // MARK: - Init
    private init() {
        guard let data = defaults.data(forKey: UserDefaultsNames.settings.rawValue) else {return}
        do {
            settings = try decoder.decode([UserDefaultsNames: SettingsModel].self, from: data)
        }
        catch {
            print("Coding settings error", error)
        }
        
        guard let city = defaults.data(forKey: UserDefaultsNames.cities.rawValue) else {return}
        do {
            cities = try decoder.decode([UserDefaultsNames: [CityCoordinatesModel]].self, from: city)
        }
        catch {
            print("Coding city error", error)
        }
    }

    
    // MARK: - Settings
    func saveSettings(_ data: SettingsModel) {
        self.settings[.settings] = data
        let key = UserDefaultsNames.settings.rawValue
        
            do {
                let data = try self.encoder.encode(self.settings)
                self.defaults.setValue(data, forKey: key)
            }
            catch {
                print("Coding error", error)
            }
    }
    

    func fetchSettings() -> Codable? {
         guard let data = defaults.data(forKey: UserDefaultsNames.settings.rawValue) else {return nil}
        do {
            let data = try decoder.decode([UserDefaultsNames: SettingsModel].self, from: data)
            return data[UserDefaultsNames.settings]
        }
        catch {
            print("Coding error", error)
            return nil
        }
    }

    
    //MARK: - Cities
    func saveCities(_ data: CityCoordinatesModel) {
        self.cities[.cities]?.append(data)
        let key = UserDefaultsNames.cities.rawValue
        
            do {
                let data = try self.encoder.encode(self.cities)
                self.defaults.setValue(data, forKey: key)
            }
            catch {
                print("Coding error", error)
            }
    }
}
