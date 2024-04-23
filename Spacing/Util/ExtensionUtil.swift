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
