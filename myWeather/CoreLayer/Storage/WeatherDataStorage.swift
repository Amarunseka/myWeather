//
//  WeatherDataStorage.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import Foundation
import UIKit

struct WeatherData {
    static var weatherData: WeatherModel?
}

struct WeatherConditionIcons {

    let iconName: String

    var icon: UIImage? {
        switch iconName {
        case "clear":
            return UIImage.sunIcon
        case "partly-cloudy", "cloudy":
            return UIImage.cloudsAndSunIcon
        case "partly-cloudy-and-light-rain", "partly-cloudy-and-rain", "partly-cloudy-and-snow", "light-rain":
            return UIImage.rainAndSunIcon
        case "overcast":
            return UIImage.cloudsIcon
        case "overcast-and-rain", "cloudy-and-light-rain", "overcast-and-light-rain", "cloudy-and-rain", "overcast-and-wet-snow", "partly-cloudy-and-light-snow", "overcast-and-snow", "cloudy-and-light-snow", "overcast-and-light-snow", "cloudy-and-snow", "rain", "showers":
            return UIImage.rainIcon
        case "overcast-thunderstorms-with-rain":
            return UIImage.thunderstormIcon
        default:
            return nil
        }
    }
}
