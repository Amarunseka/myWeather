//
//  UIFontExtension.swift
//  myWeather
//
//  Created by Миша on 03.08.2022.
//

import UIKit

enum SetFont {
    case regular
    case medium
    
    var font: String {
        switch self {
        case .regular:
            return "Rubik-Regular"
        case .medium:
            return "Rubik-Medium"
        }
    }
}

extension UIFont {
    
    static func rubik(size: CGFloat, style: SetFont) -> UIFont? {
        return UIFont.init(name: style.font, size: size)
    }
}




