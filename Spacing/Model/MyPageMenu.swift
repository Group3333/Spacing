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
    var state : State
}

extension MyPageMenu {
    static var menus : [MyPageMenu] = [
        MyPageMenu(title: "개인정보", menuIcon: UIImage(systemName: "person.crop.square")!, detailVC: "PersonalViewController",state: .Personal),
        MyPageMenu(title: "즐겨찾기", menuIcon: UIImage(systemName: "star.fill")!, detailVC: "PlaceViewController",state: .Favorite),
        MyPageMenu(title: "등록된 Place", menuIcon: UIImage(systemName: "list.bullet.clipboard")!, detailVC: "PlaceViewController", state: .Host),
        MyPageMenu(title: "이용 내역", menuIcon: UIImage(systemName: "list.bullet.clipboard")!, detailVC: "PlaceViewController", state: .Uses),
    ]
}

enum State : String{
    case Favorite = "즐겨찾기"
    case Host = "등록된 Place"
    case Main = "검색"
    case Uses = "이용 내역"
    case Personal = "개인정보"
}
