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
    
    var settings = SettingsModel()
    var cities: [UserDefaultsNames: [CityCoordinatesModel]] = [.cities: []]
    
    
    // MARK: - Init
    private init() {
        self.settings = (self.fetch(key: .settings, model: SettingsModel.self) as? SettingsModel) ?? SettingsModel()
        
//        UserDefaults.standard.removeObject(forKey: UserDefaultsNames.cities.rawValue) 
        
        
        guard let city = defaults.data(forKey: UserDefaultsNames.cities.rawValue) else {return}
        do {
            cities = try decoder.decode([UserDefaultsNames: [CityCoordinatesModel]].self, from: city)
        }
        catch {
            print("Coding city error", error)
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

    func save<T: Encodable>(key: UserDefaultsNames, model: T) async throws {
        do {
            let data = try self.encoder.encode(model.self)
            self.defaults.setValue(data, forKey: key.rawValue)
            print("save111")
        }
        catch {
            print("Coding error", error)
        }
    }
    
    
    
    func fetch<T: Decodable>(key: UserDefaultsNames, model: T.Type) -> Decodable? {
        
        guard let data = defaults.data(forKey: key.rawValue) else {return nil}
        
        do {
            let data = try decoder.decode(model.self, from: data)
            return data
        }
        catch {
            print("Coding error", error)
            return nil
        }
    }
}
