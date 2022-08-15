//
//  MainViewModel.swift
//  myWeather
//
//  Created by Миша on 03.08.2022.
//

import UIKit

protocol SlideMenuButtonTapProtocol: AnyObject {
    func didTapSlideMenu()
}


class MainViewModel {

    // MARK: - Initial properties
    weak var delegate: SlideMenuButtonTapProtocol?
    var outputSettings = UserDefaultsManager.shared.settings
    var coordinates = LocalCoordinates()
    var cities = UserDefaultsManager.shared.cities
    
    
    
    // MARK: - Public methods
    func fetchWeatherData(completion: @escaping ((Bool)->())){
        Task {
            do {
                let data = try await NetworkRequest.shared.requestWeatherData()
                WeatherData.weatherData = data
                completion(true)
            } catch {
                print(error)
                completion(false)
            }
        }
    }
    
    func fetchSpecificWeatherData(completion: @escaping ((UserDefaultsCityModel?, Bool)->())){
        guard cities[.cities]?.count != 0,
              let citiesData = cities[.cities]?[0] else {return}
        Task {
            do {
                let data = try await NetworkRequest.shared.requestSpecificCityWeatherData(latitude: citiesData.latitude, longitude: citiesData.longitude)
                WeatherData.weatherData = data
                completion(citiesData, true)
            } catch {
                print(error)
                completion(nil, false)
            }
        }
    }
    
    
    func goToDetailVC(navigation: UIViewController){
        guard let weatherData = WeatherData.weatherData?.forecasts[0].hours else {return}
        let vc = DailyForecastViewController(weatherData: weatherData)
        vc.modalPresentationStyle = .fullScreen
        navigation.present(vc, animated: true)
    }
    
    func goToDayForecast(navigation: UIViewController) {
        guard let weatherData = WeatherData.weatherData?.forecasts else {return}
        let vc = DayForecastViewController(weatherData: weatherData)
        vc.modalPresentationStyle = .fullScreen
        navigation.present(vc, animated: true)
    }
}
