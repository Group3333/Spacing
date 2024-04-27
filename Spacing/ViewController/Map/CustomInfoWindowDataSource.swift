//
//  CustomInfoWindowDataSource.swift
//  Spacing
//
//  Created by Sam.Lee on 4/27/24.
//

import Foundation
import UIKit
import NMapsMap

class CustomInfoWindowDataSource: NSObject, NMFOverlayImageDataSource {
    var title: String = ""
    init(title: String) {
        self.title = title
    }
    func view(with overlay: NMFOverlay) -> UIView {
        let label = UILabel()
        label.text = self.title
        label.backgroundColor = .spacingBeige
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)  // 글자 크기 설정
        label.textAlignment = .center
        label.numberOfLines = 0
        label.frame = CGRect(x: 0, y: 0, width: 120, height: 50)  // 정보창 크기 설정
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        return label
    }
}
