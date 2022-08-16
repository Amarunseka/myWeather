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
    var outputSettings = UserDefaultsManager.shared.settings
    var coordinates = LocalCoordinates()
    var cityInfo: CityCoordinatesModel
    
    // MARK: - Life cycle
    init(cityInfo: CityCoordinatesModel) {
        self.cityInfo = cityInfo
    }
    
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
    
    func fetchSpecificWeatherData(completion: @escaping ((Bool)->())){
        Task {
            do {
                let data = try await NetworkRequest.shared.requestSpecificCityWeatherData(latitude: cityInfo.latitude, longitude: cityInfo.longitude)
                WeatherData.weatherData = data
                completion(true)
            } catch {
                print(error)
                completion(false)
            }
        }
    }
    
    
    func goToDetailVC(navigation: UIViewController){
        guard let weatherData = WeatherData.weatherData?.forecasts[0].hours else {return}
        let regionName = cityInfo.location.convertCityLocation()
        let vc = DailyForecastViewController(regionName: regionName,weatherData: weatherData)
        vc.modalPresentationStyle = .fullScreen
        navigation.present(vc, animated: true)
    }
    
    func goToDayForecast(navigation: UIViewController) {
        guard let weatherData = WeatherData.weatherData?.forecasts else {return}
        let regionName = cityInfo.location.convertCityLocation()
        let vc = DayForecastViewController(regionName: regionName, weatherData: weatherData)
        vc.modalPresentationStyle = .fullScreen
        navigation.present(vc, animated: true)
    }
}
