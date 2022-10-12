////
////  YaFullNetModel.swift
////  WeatherApp
////
////  Created by Миша on 02.08.2022.
/////
//
//import Foundation
//
//// MARK: - YaFullNetModel
//struct YaFullNetModel: Codable {
//    let now: Int
//    let nowDt: String
//    let info: Info2
//    let fact: Fact2
//    let forecasts: [Forecast2]
//    let yesterday: Yesterday
//    let geoObject: GeoObject
//
//    enum CodingKeys: String, CodingKey {
//        case now
//        case nowDt = "now_dt"
//        case info, fact, forecasts, yesterday
//        case geoObject = "geo_object"
//    }
//}
//
//
//// MARK: - Info
//struct Info2: Codable {
//    let lat, lon: Double
//    let url: String
//    let h, defPressureMm, defPressurePa, f: Int
//    let geoid, n, nr, ns: Int
//    let nsr, p, slug: Int
//    let tzinfo: Tzinfo
//    let zoom: Int
//
//    enum CodingKeys: String, CodingKey {
//        case lat, lon, url
//        case h = "_h"
//        case defPressureMm = "def_pressure_mm"
//        case defPressurePa = "def_pressure_pa"
//        case f, geoid, n, nr, ns, nsr, p, slug, tzinfo, zoom
//    }
//}
//
//// MARK: - Fact
//struct Fact2: Codable {
//    let temp, feelsLike, tempWater: Int
//    let icon, condition: String
//    let windSpeed: Int
//    let windGust: Double
//    let windDir: String
//    let pressureMm, pressurePa, humidity: Int
//    let daytime: String
//    let polar: Bool
//    let season: String
//    let obsTime: Int
//    let accumPrec: [String: Int]
//    let cloudness: Double
//    let isThunder, precProb, precStrength, precType: Int
//    let soilMoisture: Double
//    let soilTemp: Int
//    let source: String
//    let uptime, uvIndex: Int
//
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempWater = "temp_water"
//        case icon, condition
//        case windSpeed = "wind_speed"
//        case windGust = "wind_gust"
//        case windDir = "wind_dir"
//        case pressureMm = "pressure_mm"
//        case pressurePa = "pressure_pa"
//        case humidity, daytime, polar, season
//        case obsTime = "obs_time"
//        case accumPrec = "accum_prec"
//        case cloudness
//        case isThunder = "is_thunder"
//        case precProb = "prec_prob"
//        case precStrength = "prec_strength"
//        case precType = "prec_type"
//        case soilMoisture = "soil_moisture"
//        case soilTemp = "soil_temp"
//        case source, uptime
//        case uvIndex = "uv_index"
//    }
//}
//
//// MARK: - Forecast
//struct Forecast2: Codable {
//    let date: String
//    let dateTs, week: Int
//    let sunrise, sunset: String
//    let moonCode: Int
//    let moonText: String
//    let parts: [Part2]
//    let partName: String
//    let tempMin, tempMax, tempAvg, feelsLike: Int
//    let icon, condition, daytime: String
//    let polar: Bool
//    let windSpeed, windGust: Double
//    let windDir: String
//    let pressureMm, pressurePa, humidity, precMm: Int
//    let precPeriod, precProb: Int
//    let hours: [Hour2]
//    let biomet: Biomet
//    let riseBegin, setEnd: String
//
//    enum CodingKeys: String, CodingKey {
//        case date
//        case dateTs = "date_ts"
//        case week, sunrise, sunset
//        case moonCode = "moon_code"
//        case moonText = "moon_text"
//        case parts
//        case partName = "part_name"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case tempAvg = "temp_avg"
//        case feelsLike = "feels_like"
//        case icon, condition, daytime, polar
//        case windSpeed = "wind_speed"
//        case windGust = "wind_gust"
//        case windDir = "wind_dir"
//        case pressureMm = "pressure_mm"
//        case pressurePa = "pressure_pa"
//        case humidity
//        case precMm = "prec_mm"
//        case precPeriod = "prec_period"
//        case precProb = "prec_prob"
//        case hours, biomet
//        case riseBegin = "rise_begin"
//        case setEnd = "set_end"
//    }
//}
//
//// MARK: - Biomet
//struct Biomet: Codable {
//    let condition: String
//    let index: Int
//}
//
//// MARK: - Hour
//struct Hour2: Codable {
//    let cloudness: Int
//    let condition: String
//    let feelsLike, hour, hourTs, humidity: Int
//    let icon: String
//    let isThunder, precMm, precPeriod, precProb: Int
//    let precStrength, precType, pressureMm, pressurePa: Int
//    let soilMoisture: Double
//    let soilTemp, temp, uvIndex: Int
//    let windDir: String
//    let windGust, windSpeed: Double
//
//    enum CodingKeys: String, CodingKey {
//        case cloudness, condition
//        case feelsLike = "feels_like"
//        case hour
//        case hourTs = "hour_ts"
//        case humidity, icon
//        case isThunder = "is_thunder"
//        case precMm = "prec_mm"
//        case precPeriod = "prec_period"
//        case precProb = "prec_prob"
//        case precStrength = "prec_strength"
//        case precType = "prec_type"
//        case pressureMm = "pressure_mm"
//        case pressurePa = "pressure_pa"
//        case soilMoisture = "soil_moisture"
//        case soilTemp = "soil_temp"
//        case temp
//        case uvIndex = "uv_index"
//        case windDir = "wind_dir"
//        case windGust = "wind_gust"
//        case windSpeed = "wind_speed"
//    }
//}
//
//// MARK: - Part
//struct Part2: Codable {
//    let partName: String
//    let tempMin, tempMax, tempAvg, feelsLike: Int
//    let icon, condition, daytime: String
//    let polar: Bool
//    let windSpeed, windGust: Double
//    let windDir: String
//    let pressureMm, pressurePa, humidity, precMm: Int
//    let precPeriod, precProb: Int
//    let source: String
//    let cloudness: Double
//    let precStrength, precType: Int
//    let soilMoisture: Double
//    let soilTemp, uvIndex: Int
//
//    enum CodingKeys: String, CodingKey {
//        case partName = "part_name"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case tempAvg = "temp_avg"
//        case feelsLike = "feels_like"
//        case icon, condition, daytime, polar
//        case windSpeed = "wind_speed"
//        case windGust = "wind_gust"
//        case windDir = "wind_dir"
//        case pressureMm = "pressure_mm"
//        case pressurePa = "pressure_pa"
//        case humidity
//        case precMm = "prec_mm"
//        case precPeriod = "prec_period"
//        case precProb = "prec_prob"
//        case source = "_source"
//        case cloudness
//        case precStrength = "prec_strength"
//        case precType = "prec_type"
//        case soilMoisture = "soil_moisture"
//        case soilTemp = "soil_temp"
//        case uvIndex = "uv_index"
//    }
//}
//
//// MARK: - GeoObject
//struct GeoObject: Codable {
//    let country, district, locality, province: Country
//}
//
//// MARK: - Country
//struct Country: Codable {
//    let id: Int
//    let name: String
//}
//
//
//
//// MARK: - Tzinfo
//struct Tzinfo: Codable {
//    let abbr: String
//    let dst: Int
//    let name: String
//    let offset: Int
//}
//
//// MARK: - Yesterday
//struct Yesterday: Codable {
//    let temp: Int
//}
