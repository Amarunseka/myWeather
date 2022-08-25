//
//  MainViewModel.swift
//  myWeather
//
//  Created by Миша on 03.08.2022.
//

import UIKit

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
        let vc = DependencyContainer.shared.makeDetailVC(cityInfo: cityInfo)
        guard let vc = vc else {return}
        vc.modalPresentationStyle = .fullScreen
        navigation.present(vc, animated: true)
    }
    
    func goToDayForecast(navigation: UIViewController) {
        let vc = DependencyContainer.shared.makeDayForecastVC(cityInfo: cityInfo)
        guard let vc = vc else {return}
        vc.modalPresentationStyle = .fullScreen
        navigation.present(vc, animated: true)
    }
}
