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
    static let shared: UserDefaultsManager = .init()
    
    private lazy var defaults = UserDefaults.standard
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
        
    public var settings = SettingsModel()
    public var cities: [CityCoordinatesModel] = []
    
    // MARK: - Init
    private init() {
        self.settings = self.fetch(key: .settings, model: SettingsModel.self) as? SettingsModel ?? SettingsModel()
        self.cities = self.fetch(key: .cities, model: [CityCoordinatesModel].self) as? [CityCoordinatesModel] ?? []
    }
    
    // MARK: - Methods
    public func save<T: Encodable>(key: UserDefaultsNames, model: T) async throws {
        do {
            let data = try self.encoder.encode(model.self)
            self.defaults.setValue(data, forKey: key.rawValue)
        }
        catch {
            print("Coding error", error)
        }
    }

    public func fetch<T: Decodable>(key: UserDefaultsNames, model: T.Type) -> Decodable? {
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
