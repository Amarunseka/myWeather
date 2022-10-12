//
//  SaveHelperForCoreData.swift
//  myWeather
//
//  Created by Миша on 06.10.2022.
//

import UIKit
import CoreData

class SaveHelperForCoreData {
    
    var coreDataStack = CoreDataStack(modelName: "WeatherCoreDataModel")

    
    // MARK: - Public methods
    func saveWeather(weather: WeatherModel, for city: String){

        let weatherFetch: NSFetchRequest<WeatherCDM> = WeatherCDM.fetchRequest()
        
        do {
            let weatherCDM = try coreDataStack.managedContext.fetch(weatherFetch)
            print("weatherCDM.count: ", weatherCDM.count)
            if weatherCDM.count != 0 {
                weatherCDM.forEach {
                    if let cityCDM = $0.city, city == cityCDM {
                        print(city, cityCDM)
                        coreDataStack.managedContext.delete($0)
                    }
                }
                saveWeatherToCoreData(weather: weather, for: city)
            } else {
                saveWeatherToCoreData(weather: weather, for: city)
            }
        } catch {
            print("Error fetch weather \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Private methods
    private func saveWeatherToCoreData(weather: WeatherModel, for city: String){

        print("I try to save")
        let context = coreDataStack.managedContext
        let weatherCDM = WeatherCDM(context: context)
        
        weatherCDM.city = city
        weatherCDM.now = Int64(weather.now)
        
        let fact = FactCDM(context: context)
        fact.temp = Int64(weather.fact.temp)
        fact.feelsLike = Int64(weather.fact.feelsLike)
        fact.cloudness = weather.fact.cloudness
        fact.condition = weather.fact.condition
        fact.windSpeed = weather.fact.windSpeed
        fact.humidity = Int64(weather.fact.humidity)
        
        weatherCDM.fact = fact

        /// Forecasts
        let forecasts = weatherCDM.forecasts?.mutableCopy() as? NSMutableOrderedSet
        weather.forecasts.forEach {
            let forecastCDM = ForecastCDM(context: context)
            forecastCDM.date = $0.date
            forecastCDM.dateTs = Int64($0.dateTs)
            forecastCDM.sunrise = $0.sunrise
            forecastCDM.sunset = $0.sunset
            
            // Hours
            let hours = forecastCDM.hours?.mutableCopy() as? NSMutableOrderedSet
            $0.hours.forEach{
                let hour = HourCDM(context: context)
                hour.cloudness = $0.cloudness
                hour.condition = $0.condition
                hour.feelsLike = Int64($0.feelsLike)
                hour.temp = Int64($0.temp)
                hour.hourTs = Int64($0.hourTs)
                hour.windDir = $0.windDir
                hour.windSpeed = $0.windSpeed
                hours?.add(hour)
                forecastCDM.hours = hours
            }

            // Parts
            let parts = forecastCDM.parts?.mutableCopy() as? NSMutableOrderedSet
            [$0.parts.day, $0.parts.night].forEach{
                let part = PartsCDM(context: context)
                part.tempMin = Int64($0.tempMin ?? 00)
                part.tempMax = Int64($0.tempMax ?? 00)
                part.tempAvg = Int64($0.tempAvg ?? 00)
                part.feelsLike = Int64($0.feelsLike)
                part.condition = $0.condition
                part.windSpeed = $0.windSpeed
                part.windDir = $0.windDir
                part.humidity = Int64($0.humidity)
                part.cloudness = $0.cloudness
                part.uvIndex = Int64($0.uvIndex ?? 00)
                parts?.add(part)
                forecastCDM.parts = parts
            }

            forecasts?.add(forecastCDM)
            weatherCDM.forecasts = forecasts
        }
        coreDataStack.saveContext()
    }

    
    func fetchWeatherFromCDM(for city: String, completion: @escaping (Result<WeatherModel?, Error>) -> ()){
        let weatherFetch: NSFetchRequest<WeatherCDM> = WeatherCDM.fetchRequest()
        
        do {
            let weatherCDM = try coreDataStack.managedContext.fetch(weatherFetch)
            if weatherCDM.count != 0 {
                weatherCDM.forEach {
                    if let cityCDM = $0.city, city == cityCDM {
                        completion(.success(converterWeatherData(from: $0)))
                    }
                }
            } else {
                print("Weather CoreData is empty")
                completion(.failure(CoreDataStackError.noFinalResult))
            }
        } catch {
            print("Error fetch weather \(error.localizedDescription)")
            completion(.failure(CoreDataStackError.noFetchRequest))

        }
    }

    private func converterWeatherData(from data: WeatherCDM) -> WeatherModel?{
        
        let now = Int(data.now)
        
        guard let safeFact = data.fact else {return nil}
        let fact = Fact(data: safeFact)
        
        var forecasts: [Forecast] = []
        let forecastsSet = data.forecasts
        forecastsSet?.forEach{
            let item = $0 as? ForecastCDM
            if let item = item {
                forecasts.append(Forecast(data: item))
            }
        }
        
        let weather = WeatherModel(now: now,
                                   fact: fact,
                                   forecasts: forecasts)
        
        return weather
    }
}
