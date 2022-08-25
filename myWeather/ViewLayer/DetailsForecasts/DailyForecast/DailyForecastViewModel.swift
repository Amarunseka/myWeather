//
//  DailyForecastViewModel.swift
//  myWeather
//
//  Created by Миша on 24.08.2022.
//

import Foundation

class DailyForecastViewModel {
    // MARK: - Initial properties
    let weatherData: [Hour]
    let regionName: String

    // MARK: - Life cycle
    init(regionName: String, weatherData: [Hour]) {
        self.regionName = regionName
        self.weatherData = weatherData
    }
}
