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
    
    func requestData() async throws -> NetWeatherModel {
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        let coordinates = LocalCoordinates.coordinates
        let key = "b2b504f2-d533-4bae-82a4-3568857596b6"
        let headers = HTTPHeaders(["X-Yandex-API-Key" : "\(key)"])
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&lang=ru_RU&limit=7&hours=true&extra=true"
        
        guard let url = URL(string: urlString) else {throw NetErrors.wrongURL}
        
        return try await AF.request(url, method: .get, headers: headers).serializingDecodable(NetWeatherModel.self, decoder: decoder).value
    }
}
