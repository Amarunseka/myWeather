//
//  UILabelExtension.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

extension UILabel {
    
    static func setWhiteLabel(text: String, fontSize: CGFloat, fontStyle: SetFont) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.rubik(size: fontSize, style: fontStyle)
        label.textColor = .white
        return label
    }
    
    static func setBlackLabel(text: String, fontSize: CGFloat, fontStyle: SetFont) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.rubik(size: fontSize, style: fontStyle)
        label.textColor = .black
        return label
    }
    
    static func setColorLabel(text: String, fontSize: CGFloat, fontStyle: SetFont, fontColor: UIColor) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.rubik(size: fontSize, style: fontStyle)
        label.textColor = fontColor
        return label
    }
}
