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
    var cityInfo: CityCoordinatesModel
    let saver = SaveHelperForCoreData()

    
    // MARK: - Life cycle
    init(cityInfo: CityCoordinatesModel) {
        self.cityInfo = cityInfo
    }
    
    // MARK: - Public methods
    func fetchWeather(viewController: UIViewController, completion: @escaping (Bool) -> ()){
        
        fetchWeatherData { [weak self] netResult in
            guard let self = self else {return}
            
            switch netResult {
            case true:
                
                if let weather = WeatherData.weatherData {
                    self.saver.saveWeather(weather: weather, for: self.cityInfo.location)
                }
                completion(true)
                
            case false:
                self.unfoldWeatherFromCD { CDResult in
                    
                    if CDResult {
                        let alert = UIAlertController(title: "Error net loading",
                                                      message: "Couldn't download the weather data from net. There is a local save data. Show?",
                                                      preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Ok", style: .default) {_ in
                            completion(true)
                        }
                        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                            completion(false)
                        }
                        
                        alert.addAction(cancel)
                        alert.addAction(ok)
                        DispatchQueue.main.async {
                            viewController.present(alert, animated: true)
                        }
                        
                        
                        print("Нет соединения, но есть сохраненные данные. Показать?")
                    } else {
                        print("Нет соединения попробуйте позднее")
                        completion(false)
                    }
                }
            }
        }
    }


    func fetchWeatherData(completion: @escaping ((Bool)->())){
        Task {
            do {
                let data = try await NetworkRequest.shared.requestCityWeatherData(latitude: cityInfo.latitude, longitude: cityInfo.longitude)
                WeatherData.weatherData = data
                completion(true)
            } catch {
                print(error)
                completion(false)
            }
        }
    }
    
    
    func unfoldWeatherFromCD(completion: @escaping ((Bool)->())){
        let saver = SaveHelperForCoreData()

        saver.fetchWeatherFromCDM(for: cityInfo.location) {result in
            switch result {
                
            case .success(let weather):
                WeatherData.weatherData = weather
                completion(true)
            case .failure(let error):
                completion(false)
                print(error)
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
