//
//  MainPageViewModel.swift
//  myWeather
//
//  Created by Миша on 21.08.2022.
//

import Foundation

protocol SlideMenuButtonTapProtocol: AnyObject {
    func didTapSlideMenu()
}

class MainPageViewModel {
    // MARK: - Initial properties
    var cities: [CityCoordinatesModel]? {
        didSet {
            DependencyContainer.shared.cities = cities
        }
    }
    weak var delegateTapMenu: SlideMenuButtonTapProtocol?

    // MARK: - Life cycle
    init(cities: [CityCoordinatesModel]?) {
        self.cities = cities
    }
    
    // MARK: - Private methods

    // MARK: - Public methods
    public func createViewController() -> [MainViewController] {
        var controllers = [MainViewController]()
        self.cities?.forEach{
            controllers.append(DependencyContainer.shared.makeMainVC(cityInfo: $0))
        }
        return controllers
    }
}
