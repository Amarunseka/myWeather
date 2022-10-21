//
//  UILabelExtension.swift
//  myWeather
//
//  Created by Миша on 04.08.2022.
//

import UIKit

extension UILabel {
    
    /// initial labels
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
    
    
    /// icon
    func setIcon(text:String, icon: UIImage?) {
        semanticContentAttribute = .forceLeftToRight
        let leftAttachment = NSTextAttachment()
        leftAttachment.image = icon

        let leftAttachmentStr = NSAttributedString(attachment: leftAttachment)
        let myString = NSMutableAttributedString(string: "")
        
        if icon != nil {
            leftAttachment.bounds = CGRect(x: 0, y: -6, width: 22, height: 22)
            myString.append(leftAttachmentStr)
            myString.append(NSAttributedString(string: " "))
        }
        myString.append(NSAttributedString(string: text))
        attributedText = myString
    }
    
    func setIconWithSize(text:String, icon: UIImage?, width: CGFloat, height: CGFloat) {
        semanticContentAttribute = .forceLeftToRight
        let leftAttachment = NSTextAttachment()
        leftAttachment.image = icon
        
        let leftAttachmentStr = NSAttributedString(attachment: leftAttachment)
        let myString = NSMutableAttributedString(string: "")
        
        if icon != nil {
            leftAttachment.bounds = CGRect(x: 0, y: -6, width: width, height: height)
            myString.append(leftAttachmentStr)
            myString.append(NSAttributedString(string: " "))
        }
        myString.append(NSAttributedString(string: text))
        attributedText = myString
    }
}
