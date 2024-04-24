//
//  myPageMenu.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import Foundation
import UIKit

struct MyPageMenu {
    var title : String
    var menuIcon : UIImage
    var detailVC : String
    var touchIcon = UIImage(systemName: "chevron.right")
}

extension MyPageMenu {
    static var menus : [MyPageMenu] = [
        MyPageMenu(title: "개인정보", menuIcon: UIImage(systemName: "person.crop.square")!, detailVC: "PersonalViewController"),
        MyPageMenu(title: "즐겨찾기", menuIcon: UIImage(systemName: "star.fill")!, detailVC: "PlaceViewController"),
        MyPageMenu(title: "등록된 Place", menuIcon: UIImage(systemName: "list.bullet.clipboard")!, detailVC: "PlaceViewController"),
    ]
}

enum State : String{
    case Favorite = "즐겨찾기"
    case Host = "등록된 Place"
    case Main = "검색"
}
