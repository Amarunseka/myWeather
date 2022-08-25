//
//  DependencyInjectionContainer.swift
//  myWeather
//
//  Created by Миша on 23.08.2022.
//

import UIKit

class DependencyContainer{
    
    static let shared = DependencyContainer.init()
    
    var cities = UserDefaultsManager.shared.cities[.cities]

    func makeSlideMenuContainerVC()->SlideMenuContainerViewController {
        let vm = SlideMenuContainerViewModel()
        let vc = SlideMenuContainerViewController(viewModel: vm)
        return vc
    }
    
    func makeSlideMenuVC()->SlideMenuViewController {
        let vm = SlideMenuViewModel()
        let vc = SlideMenuViewController(viewModel: vm)
        return vc
    }
    
    func makeMainPageVC()->MainPageViewController {
        let vm = MainPageViewModel(cities: cities)
        let vc = MainPageViewController(viewModel: vm)
        return vc
    }

    func makeMainVC(cityInfo: CityCoordinatesModel) -> MainViewController{
        let vm = MainViewModel(cityInfo: cityInfo)
        let vc = MainViewController(viewModel: vm)
        return vc
    }
    
    func makeDetailVC(cityInfo: CityCoordinatesModel) -> DailyForecastViewController?{
        guard let weatherData = WeatherData.weatherData?.forecasts[0].hours else {return nil}
        let regionName = cityInfo.location.convertCityLocation()
        let vm = DailyForecastViewModel(regionName: regionName,weatherData: weatherData)
        let vc = DailyForecastViewController(viewModel: vm)
        return vc
    }
    
    func makeDayForecastVC(cityInfo: CityCoordinatesModel) -> DayForecastViewController?{
        guard let weatherData = WeatherData.weatherData?.forecasts else {return nil}
        let regionName = cityInfo.location.convertCityLocation()
        let vm = DayForecastViewModel(regionName: regionName, weatherData: weatherData)
        let vc = DayForecastViewController(viewModel: vm)
        return vc
    }
    
    func makeChoseLocationVC() -> ChoseLocationViewController {
        let vm = ChoseLocationViewModel()
        let vc = ChoseLocationViewController(viewModel: vm)
        return vc
    }
    
    func makeSettingsVC() -> SettingsViewController {
        let vm = SettingsViewModel()
        let vc = SettingsViewController(viewModel: vm)
        return vc
    }
}
