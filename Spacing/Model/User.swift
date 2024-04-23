//
//  User.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import Foundation
import UIKit

struct User {
    var name : String
    var profileImage : UIImage
    let email : String
    let nickName : String
    let gender : Gender
    var favorite : [Place]
    var hostPlace : [Place]
    var isLogin : Bool
}

enum Gender : String{
    case Male = "남자"
    case Female = "여자"
}
