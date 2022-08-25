//
//  NetworkRequest.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import Foundation
import Alamofire

enum NetErrors: String, Error {
    case wrongURL = "Wrong URL"
}

class NetworkRequest {
    
    static let shared = NetworkRequest()

    private init(){}
    
    func requestWeatherData() async throws -> NetWeatherModel {
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        let coordinates = LocalCoordinates.coordinates
        let key = "b2b504f2-d533-4bae-82a4-3568857596b6"
        let headers = HTTPHeaders(["X-Yandex-API-Key" : "\(key)"])
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&lang=ru_RU&limit=7&hours=true&extra=true"
        print("latitude \(coordinates.latitude)\nlongitude \(coordinates.longitude)")
        guard let url = URL(string: urlString) else {throw NetErrors.wrongURL}
        
        
        
//        /// получение ответа в формате типа JSON (погода)
//        AF.request(url, method: .get, headers: headers).responseJSON { response in
//            switch response.result {
//            case .success(_):
//                print(response)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
        
        return try await AF.request(url, method: .get, headers: headers).serializingDecodable(NetWeatherModel.self, decoder: decoder).value
    }
    
    
    func requestSpecificCityWeatherData(latitude: String, longitude: String) async throws -> NetWeatherModel {
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        let key = "b2b504f2-d533-4bae-82a4-3568857596b6"
        let headers = HTTPHeaders(["X-Yandex-API-Key" : "\(key)"])
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&lang=ru_RU&limit=7&hours=true&extra=true"
        
        guard let url = URL(string: urlString) else {throw NetErrors.wrongURL}
        
        return try await AF.request(url, method: .get, headers: headers).serializingDecodable(NetWeatherModel.self, decoder: decoder).value
    }
    
    
    
    func requestCityCoordinates(for city: String) async throws -> CityInfoModel {
        let keyCoder = "e62f1386-c41a-4be8-a8b8-ece5bef3d3be"

        guard let urlStringCoder = "https://geocode-maps.yandex.ru/1.x/?apikey=\(keyCoder)&lang=en_RU&format=json&geocode=\(city)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let urlCoder = URL(string: urlStringCoder) else {
            throw NetErrors.wrongURL}

        return try await AF.request(urlCoder, method: .get).serializingDecodable(CityInfoModel.self).value
    }
    
    
}
