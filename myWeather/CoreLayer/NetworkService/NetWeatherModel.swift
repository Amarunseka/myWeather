//
//  NetWeatherModel.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import Foundation

// MARK: - NetWeatherModel
struct NetWeatherModel: Codable {
    let now: Int
    let nowDt: String
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
}

// MARK: - Info
struct Info: Codable {
    let lat: Double
    let lon: Double
    let url: String
}

// MARK: - Fact
struct Fact: Codable {
    let temp: Int
    let feelsLike: Int
    let cloudness: Double
    let tempWater: Int?
    let icon: String
    let condition: String
    let windSpeed: Double
    let windGust: Double
    let windDir: String
    let pressureMm: Int
    let pressurePa: Int
    let humidity: Int
    let daytime: String
    let polar: Bool
    let season: String
    let obsTime: Int
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let dateTs: Int
    let week: Int
//    let humidity: Int
    let sunrise: String
    let sunset: String
    let moonCode: Int
    let moonText: String
    let hours: [Hour]
    let parts: Parts
}

// MARK: - Hour
struct Hour: Codable {
    let cloudness: Double
    let condition: String
    let feelsLike: Int
    let hour: String
    let hourTs: Int
    let humidity: Int
    let icon: String
    let isThunder: Bool
    let precMm: Int?
    let precPeriod: Int
    let precProb: Int
    let precStrength: Int
    let precType: Int
    let pressureMm: Int
    let pressurePa: Int
    let soilMoisture: Double?
    let soilTemp: Int?
    let temp: Int
    let uvIndex: Int
    let windDir: String
    let windGust: Double
    let windSpeed: Double
}

struct Parts: Codable {
    let day: PartOfTheDay
    let dayShort: PartOfTheDay
    let evening: PartOfTheDay
    let morning: PartOfTheDay
    let night: PartOfTheDay
    let nightShort: PartOfTheDay
}

// MARK: - PartOfTheDay
struct PartOfTheDay: Codable {
    let temp: Int?
    let tempMin: Int?
    let tempMax: Int?
    let tempAvg: Int?
    let feelsLike: Int
    let icon: String
    let condition: String
    let daytime: String
    let polar: Bool
    let windSpeed: Double
    let windGust: Double
    let windDir: String
    let pressureMm: Int
    let pressurePa: Int
    let humidity: Int
    let precMm: Double
    let precPeriod: Int
    let precProb: Int
    let precStrength: Int
    let cloudness: Double
}
























//// MARK: - NetWeatherModel
//struct NetWeatherModel: Codable {
//    let now: Int
//    let nowDt: String
//    let info: Info
//    let fact: Fact
//    let forecasts: [Forecast]
////
////    enum CodingKeys: String, CodingKey {
////        case now
////        case nowDt = "now_dt"
////        case info
////        case fact
////        case forecasts
////    }
//}
//
//// MARK: - Info
//struct Info: Codable {
//    let lat: Double
//    let lon: Double
//    let url: String
//}
//
//// MARK: - Fact
//struct Fact: Codable {
//    let temp, feelsLike: Int
//    let tempWater: Int?
//    let icon, condition: String
//    let windSpeed: Double
//    let windGust: Double
//    let windDir: String
//    let pressureMm, pressurePa, humidity: Int
//    let daytime: String
//    let polar: Bool
//    let season: String
//    let obsTime: Int
////
////    enum CodingKeys: String, CodingKey {
////        case temp
////        case feelsLike = "feels_like"
////        case tempWater = "temp_water"
////        case icon, condition
////        case windSpeed = "wind_speed"
////        case windGust = "wind_gust"
////        case windDir = "wind_dir"
////        case pressureMm = "pressure_mm"
////        case pressurePa = "pressure_pa"
////        case humidity, daytime, polar, season
////        case obsTime = "obs_time"
////    }
//}
//
//// MARK: - Forecast
//struct Forecast: Codable {
//    let date: String
//    let dateTs, week: Int
//    let sunrise, sunset: String
//    let moonCode: Int
//    let moonText: String
//    let hours: [Hour]
//    let parts: Parts
////
////    enum CodingKeys: String, CodingKey {
////        case date
////        case dateTs = "date_ts"
////        case week, sunrise, sunset
////        case moonCode = "moon_code"
////        case moonText = "moon_text"
////        case hours
////        case parts
////    }
//}
//
//// MARK: - Hour
//struct Hour: Codable {
//    let cloudness: Double
//    let condition: String
//    let feelsLike: Int
//    let hour: String
//    let hourTs: Int
//    let humidity: Int
//    let icon: String
//    let isThunder: Bool
//    let precMm: Int
//    let precPeriod: Int
//    let precProb: Int
//    let precStrength: Int
//    let precType: Int
//    let pressureMm: Int
//    let pressurePa: Int
//    let soilMoisture: Double
//    let soilTemp: Int
//    let temp: Int
//    let uvIndex: Int
//    let windDir: String
//    let windGust: Double
//    let windSpeed: Double
////
////    enum CodingKeys: String, CodingKey {
////        case cloudness
////        case condition
////        case feelsLike = "feels_like"
////        case hour
////        case hourTs = "hour_ts"
////        case humidity
////        case icon
////        case isThunder = "is_thunder"
////        case precMm = "prec_mm"
////        case precPeriod = "prec_period"
////        case precProb = "prec_prob"
////        case precStrength = "prec_strength"
////        case precType = "prec_type"
////        case pressureMm = "pressure_mm"
////        case pressurePa = "pressure_pa"
////        case soilMoisture = "soil_moisture"
////        case soilTemp = "soil_temp"
////        case temp
////        case uvIndex = "uv_index"
////        case windDir = "wind_dir"
////        case windGust = "wind_gust"
////        case windSpeed = "wind_speed"
////    }
//}
//
//struct Parts: Codable {
//    let day: PartOfTheDay
//    let dayShort: PartOfTheDay
//    let evening: PartOfTheDay
//    let morning: PartOfTheDay
//    let night: PartOfTheDay
//    let nightShort: PartOfTheDay
////
////    enum CodingKeys: String, CodingKey {
////        case day
////        case dayShort = "day_short"
////        case evening
////        case morning
////        case night
////        case nightShort = "night_short"
////    }
//}
//
//// MARK: - PartOfTheDay
//struct PartOfTheDay: Codable {
//    let temp: Int?
//    let tempMin: Int?
//    let tempMax: Int?
//    let tempAvg: Int?
//    let feelsLike: Int
//    let icon: String
//    let condition: String
//    let daytime: String
//    let polar: Bool
//    let windSpeed: Double
//    let windGust: Double
//    let windDir: String
//    let pressureMm: Int
//    let pressurePa: Int
//    let humidity: Int
//    let precMm: Double
//    let precPeriod: Int
//    let precProb: Int
////
////    enum CodingKeys: String, CodingKey {
////        case temp
////        case tempMin = "temp_min"
////        case tempMax = "temp_max"
////        case tempAvg = "temp_avg"
////        case feelsLike = "feels_like"
////        case icon
////        case condition
////        case daytime
////        case polar
////        case windSpeed = "wind_speed"
////        case windGust = "wind_gust"
////        case windDir = "wind_dir"
////        case pressureMm = "pressure_mm"
////        case pressurePa = "pressure_pa"
////        case humidity
////        case precMm = "prec_mm"
////        case precPeriod = "prec_period"
////        case precProb = "prec_prob"
////    }
//}
