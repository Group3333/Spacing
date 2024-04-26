//
//  ExtensionUtil.swift
//  Spacing
//
//  Created by Sam.Lee on 4/23/24.
//

import Foundation
import UIKit

extension String {
    // 블로그 참고
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension Int {
    static func addCommas(to number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}


extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UIColor {
    static var spacingOrange: UIColor {
        return .init(red: 255/255, green: 64/255, blue: 0, alpha: 1)
    }
    
    static var spacingSalmon: UIColor {
        return .init(red: 250/255, green: 170/255, blue: 141/255, alpha: 1)
    }
    
    static var spacingDarkGray: UIColor {
        return .init(red: 32/255, green: 30/255, blue: 31/255, alpha: 1)
    }
    
    static var spacingGray: UIColor {
        return .init(red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
    }
    
    static var spacingLightGray: UIColor {
        return .init(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
    }
    
    static var spacingBeige: UIColor {
        return .init(red: 254/255, green: 239/255, blue: 221/255, alpha: 1)
    }
    
    static var spacingWhite: UIColor {
        return .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
}
