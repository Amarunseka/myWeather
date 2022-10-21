//
//  Sizes.swift
//  myWeather
//
//  Created by Миша on 13.10.2022.
//

import Foundation

/*
 iPhone 11:
  - 414
  - 896

 iPad Pro:
  - 1024
  - 1366
 
 iPone SE
  - 375
  - 667

 */

struct SizesStorage {
    static var fontSizes = FontSizes()
    static var currentWeatherViewSpacings = CurrentWeatherViewSpacings()
    static var barButtonItemSizes = BarButtonItemSizes()
    static var standartSpacingSizes = StandartSpacingSizes()
    static var cellSizes = CellSizes()
    static var iconSizes = IconSizes()
    static var onBoardingSizes = OnBoardingSizes()
}

enum SetSizes {
    case iPhone
    case iPad
    case iPod

    var fontSizes: FontSizes {
        switch self {
        case .iPhone:
            return FontSizes(standartFontSize: 14, bigFontSize: 16, enormousFontSize: 36, smallFontSize: 12, titleFontSize: 18)
        case .iPad:
            return FontSizes(standartFontSize: 30, bigFontSize: 33, enormousFontSize: 65, smallFontSize: 18, titleFontSize: 36)
        case .iPod:
            return FontSizes(standartFontSize: 12, bigFontSize: 14, enormousFontSize: 27, smallFontSize: 8, titleFontSize: 16)
        }
    }
    
    var standartSpacingSizes: StandartSpacingSizes {
        switch self {
            
        case .iPhone:
            return StandartSpacingSizes(sideSpacing: 16, betweenElementsSpacing: 5)
        case .iPad:
            return StandartSpacingSizes(sideSpacing: 32, betweenElementsSpacing: 10)
        case .iPod:
            return StandartSpacingSizes(sideSpacing: 14, betweenElementsSpacing: 5)
        }
    }
    
    var barButtonItemSizes: BarButtonItemSizes {
        switch self {
        case .iPhone:
            return BarButtonItemSizes(height: 16, menuIconWidth: 30, geolocationIconWidth: 20)
        case .iPad:
            return BarButtonItemSizes(height: 35, menuIconWidth: 40, geolocationIconWidth: 33)
        case .iPod:
            return BarButtonItemSizes(height: 14, menuIconWidth: 20, geolocationIconWidth: 14)
        }
    }
    
    var currentWeatherViewSpacings: CurrentWeatherViewSpacings {
        switch self {
        case .iPhone:
            return CurrentWeatherViewSpacings(betweenSunriseSW: 3, betweenCurrentTempSW: 5, betweenPrecipitationSW: 20, currentDateBottom: 20)
        case .iPad:
            return CurrentWeatherViewSpacings(betweenSunriseSW: 7, betweenCurrentTempSW: 12, betweenPrecipitationSW: 40, currentDateBottom: 40)
        case .iPod:
            return CurrentWeatherViewSpacings(betweenSunriseSW: 3, betweenCurrentTempSW: 5, betweenPrecipitationSW: 18, currentDateBottom: 18)
        }
    }
    
    var cellSizes: CellSizes {
        switch self {
        case .iPhone:
            return CellSizes(hoursCW:(50,80), sevenDaysTW: 55, detailsTW: 155, choseDayCW: (100, 30), parts: (300, 40))
        case .iPad:
            return CellSizes(hoursCW:(100,150), sevenDaysTW: 100, detailsTW: 280, choseDayCW: (200, 60), parts: (600, 80))
        case .iPod:
            return CellSizes(hoursCW:(48,75), sevenDaysTW: 50, detailsTW: 150, choseDayCW: (90, 25), parts: (300, 40))
        }
    }
    
    var iconSizes: IconSizes {
        switch self {
        case .iPhone:
            return IconSizes(small: 16, middle: 20, big: 36)
        case .iPad:
            return IconSizes(small: 32, middle: 40, big: 62)
        case .iPod:
            return IconSizes(small: 15, middle: 18, big: 35)
        }
    }
    
    var onBoardingSizes: OnBoardingSizes {
        switch self {
        case .iPhone:
            return OnBoardingSizes(imageSize: 200, topSpacing: 10, sideSpacing: 20)
        case .iPad:
            return OnBoardingSizes(imageSize: 350, topSpacing: 15, sideSpacing: 40)
        case .iPod:
            return OnBoardingSizes(imageSize: 190, topSpacing: 8, sideSpacing: 18)
        }
    }
}

struct FontSizes {
    var standartFontSize: CGFloat = 0
    var bigFontSize: CGFloat = 0
    var enormousFontSize: CGFloat = 0
    var smallFontSize: CGFloat = 0
    var titleFontSize: CGFloat = 0
}

struct StandartSpacingSizes {
    var sideSpacing: CGFloat = 0
    var betweenElementsSpacing: CGFloat = 0
}

struct BarButtonItemSizes {
    var height: CGFloat = 0
    var menuIconWidth: CGFloat = 0
    var geolocationIconWidth: CGFloat = 0
}

struct CurrentWeatherViewSpacings {
    var betweenSunriseSW: CGFloat  = 0
    var betweenCurrentTempSW: CGFloat  = 0
    var betweenPrecipitationSW: CGFloat  = 0
    var currentDateBottom: CGFloat  = 0
}

struct CellSizes {
    var hoursCW: (CGFloat, CGFloat) = (width: 0, height: 0)
    var sevenDaysTW: CGFloat = 0
    var detailsTW: CGFloat = 0
    var choseDayCW: (CGFloat, CGFloat) = (width: 0, height: 0)
    var parts: (CGFloat, CGFloat) = (view: 0, tableView: 0)
}

struct IconSizes {
    var small: CGFloat = 0
    var middle: CGFloat = 0
    var big: CGFloat = 0
}

struct OnBoardingSizes {
    var imageSize: CGFloat = 0
    var topSpacing: CGFloat = 0
    var sideSpacing: CGFloat = 0
}
