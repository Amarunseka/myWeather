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
 
    func requestCityWeatherData(latitude: String, longitude: String) async throws -> WeatherModel {
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        let oldKey = "f993c9fa-6ec5-4ca8-96c8-a260e6b693b2"
        let key = "069674d4-3326-4860-9277-c94c9fdd8505"

        let headers = HTTPHeaders(["X-Yandex-API-Key" : "\(key)"])
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&lang=ru_RU&limit=7&hours=true&extra=true"
        
        guard let url = URL(string: urlString) else {throw NetErrors.wrongURL}
        
        return try await AF.request(url, method: .get, headers: headers).serializingDecodable(WeatherModel.self, decoder: decoder).value
    }
    
    
    
    func requestCityCoordinates(for city: String) async throws -> CityInfoModelContainer {
        let keyCoder = "e62f1386-c41a-4be8-a8b8-ece5bef3d3be"

        guard let urlStringCoder = "https://geocode-maps.yandex.ru/1.x/?apikey=\(keyCoder)&lang=en_RU&format=json&geocode=\(city)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let urlCoder = URL(string: urlStringCoder) else {
            throw NetErrors.wrongURL}

        return try await AF.request(urlCoder, method: .get).serializingDecodable(CityInfoModelContainer.self).value
    }
    
    
//    /// получение ответа в формате типа JSON (город)
//    func requestCityCoordinates22() {
//        let keyCoder = "e62f1386-c41a-4be8-a8b8-ece5bef3d3be"
//
//        guard let urlStringCoder = "https://geocode-maps.yandex.ru/1.x/?apikey=\(keyCoder)&lang=en_RU&format=json&geocode=moscow".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//              let urlCoder = URL(string: urlStringCoder) else {
//            return}
//
//        AF.request(urlCoder, method: .get).responseJSON { response in
//            switch response.result {
//            case .success(_):
//                print(response)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
