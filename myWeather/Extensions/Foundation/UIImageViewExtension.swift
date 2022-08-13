//
//  UIImageViewExtension.swift
//  myWeather
//
//  Created by Миша on 03.08.2022.
//

import UIKit

extension UIImageView {
    
    static func setImage(_ imageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
