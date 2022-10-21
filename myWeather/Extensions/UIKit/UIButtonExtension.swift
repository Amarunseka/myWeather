//
//  UIButtonExtension.swift
//  myWeather
//
//  Created by Миша on 08.08.2022.
//

import UIKit

extension UIButton {
    
    
    static func setButton(title: String, color: UIColor, fontSize: CGFloat) -> UIButton{
        
        let button = UIButton(type: .system)
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .rubik(size: fontSize, style: .regular)
        button.layer.cornerRadius = 10
        return button
    }
    
    static func setNavItemButton(image: String, width: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        let image = UIImage(named: image)
        button.frame = CGRect(x: 0, y: 0, width: width, height: SizesStorage.barButtonItemSizes.height)
        button.setBackgroundImage(image, for: .normal)
        return button
    }
}



