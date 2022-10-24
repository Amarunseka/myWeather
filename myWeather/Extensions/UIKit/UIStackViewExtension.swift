//
//  UIStackViewExtension.swift
//  myWeather
//
//  Created by Миша on 13.10.2022.
//

import UIKit

extension UIStackView {
    
    static func set(subViews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.axis = axis
        stackView.spacing = spacing
        return stackView
    }
}
