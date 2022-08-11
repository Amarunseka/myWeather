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
        case editing = "Editing"
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
        
        var currentVC: UIViewController {
            switch self {
            case .mainScreenVC:
                return MainViewController()
            case .editing:
                return EditingViewController()
            case .location:
                return ChoseLocationViewController()

            }
        }
    }
}
