//
//  DayForecastViewModel.swift
//  myWeather
//
//  Created by Миша on 24.08.2022.
//

import Foundation

class DayForecastViewModel {
    // MARK: - Initial properties
    let weatherData: [Forecast]
    let regionName: String

    // MARK: - Life cycle
    init(regionName: String, weatherData: [Forecast]) {
        self.regionName = regionName
        self.weatherData = weatherData
    }
}
