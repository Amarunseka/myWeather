//
//  ChoseLocationViewModel.swift
//  myWeather
//
//  Created by Миша on 23.08.2022.
//

import Foundation

class ChoseLocationViewModel {
    // MARK: - Initial properties

    // MARK: - Life cycle

    // MARK: - Public methods
    func getCityInfo(city: String) {
        Task {
            do {
                let cityInfo = try await NetworkRequest.shared.requestCityCoordinates(for: city)
                let (longitude, latitude, address) = self.convertCityInfo(data: cityInfo)
                let data = CityCoordinatesModel(location: address, latitude: latitude, longitude: longitude)

                UserDefaultsManager.shared.saveCities(data)
                DispatchQueue.main.sync {
                    NotificationCenter.default.post(name: Notification.Name("addLocation"), object: nil)
                }
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Private methods
    private func convertCityInfo(data: CityInfoModel?) -> (String, String, String){
        if let coder = data?.response.geoObjectCollection.featureMember,
           !coder.isEmpty {
            let coordinates = coder[0].geoObject.point
            let coordinatesArray = coordinates.pos.split(separator: " ")
            
            let longitude = coordinatesArray[0]
            let latitude = coordinatesArray[1]
            let address = coder[0].geoObject.metaDataProperty.geocoderMetaData.address.formatted
            
            return("\(longitude)", "\(latitude)", "\(address)")
        } else {
            return ("","","")
        }
    }
}


