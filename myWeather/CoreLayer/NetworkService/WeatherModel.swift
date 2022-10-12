//
//  NetWeatherModel.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import Foundation

// MARK: - NetWeatherModel
struct WeatherModel: Codable {
    let now: Int
    var fact: Fact
    let forecasts: [Forecast]
}

// MARK: - Fact
struct Fact: Codable {
    var temp: Int
    let feelsLike: Int
    let cloudness: Double
    let condition: String
    let windSpeed: Double
    let humidity: Int
    
    init(data: FactCDM) {
        self.temp = Int(data.temp)
        self.feelsLike = Int(data.feelsLike)
        self.cloudness = data.cloudness
        self.condition = data.condition ?? ""
        self.windSpeed = data.windSpeed
        self.humidity = Int(data.humidity)
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let dateTs: Int
    let sunrise: String
    let sunset: String
    let hours: [Hour]
    let parts: Parts
    
    init(data: ForecastCDM) {
        self.date = data.date ?? ""
        self.dateTs = Int(data.dateTs)
        self.sunrise = data.sunrise ?? ""
        self.sunset = data.sunset ?? ""
        
        
        var hours: [Hour] = []
        data.hours?.forEach{ hour in
            if let hour = hour as? HourCDM {
                hours.append(Hour(data: hour))
            }
        }
        self.hours = hours

        
        let day = (data.parts?[0] as? PartsCDM)
        let night = (data.parts?[1] as? PartsCDM)
        let parts = Parts(day: PartOfTheDay(data: day!),
                          night: PartOfTheDay(data: night!))
        
        self.parts = parts
    }
}

// MARK: - Hour
struct Hour: Codable {
    let cloudness: Double
    let condition: String
    let feelsLike: Int
    let temp: Int
    let hourTs: Int
    let windDir: String
    let windSpeed: Double
    
    init(data: HourCDM) {
        self.cloudness = data.cloudness
        self.condition = data.condition ?? ""
        self.feelsLike = Int(data.feelsLike)
        self.temp = Int(data.temp)
        self.hourTs = Int(data.hourTs)
        self.windDir = data.windDir ?? ""
        self.windSpeed = data.windSpeed
    }
}

struct Parts: Codable {
    let day: PartOfTheDay
    let night: PartOfTheDay
}

// MARK: - PartOfTheDay
struct PartOfTheDay: Codable {
    let tempMin: Int?
    let tempMax: Int?
    let tempAvg: Int?
    let feelsLike: Int
    let condition: String
    let windSpeed: Double
    let windDir: String
    let humidity: Int
    let cloudness: Double
    let uvIndex: Int?
    
    init(data: PartsCDM) {
        self.tempMin = Int(data.tempMin)
        self.tempMax = Int(data.tempMax)
        self.tempAvg = Int(data.tempAvg)
        self.feelsLike = Int(data.feelsLike)
        self.condition = data.condition ?? ""
        self.windSpeed = data.windSpeed
        self.windDir = data.windDir ?? ""
        self.humidity = Int(data.humidity)
        self.cloudness = data.cloudness
        self.uvIndex = Int(data.uvIndex)
    }
}
