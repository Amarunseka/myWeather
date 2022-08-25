//
//  SlideMenuViewModel.swift
//  myWeather
//
//  Created by Миша on 09.08.2022.
//

import UIKit

protocol SlideMenuItemsTapProtocol: AnyObject {
    func didSelectMenuItem(menuItem: SlideMenuViewModel.MenuItems)
}

class SlideMenuViewModel {
    
    // MARK: - Initial properties
    weak var delegate: SlideMenuItemsTapProtocol?
    
    enum MenuItems: String, CaseIterable {
        case mainScreenVC = "Weather"
        case editing = "Settings"
        case location = "Moscow"
        
        var iconImage: String {
            switch self {
            case .mainScreenVC:
                return "cloudsAndSun"
            case .editing:
                return "editingIcon"
            case .location:
                return "geolocationIcon"
            }
        }
        
        var chosenVC: UIViewController {
            switch self {
            case .mainScreenVC:
                return DependencyContainer.shared.makeMainPageVC()
            case .editing:
                return DependencyContainer.shared.makeSettingsVC()
            case .location:
                return DependencyContainer.shared.makeChoseLocationVC()
            }
        }
    }
}
