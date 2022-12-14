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
    
    // MARK: - Public methods
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
