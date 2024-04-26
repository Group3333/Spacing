//
//  User.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import Foundation
import UIKit

struct User{
    var name : String
    var profileImage : UIImage
    var email : String
    var nickName : String
    var gender : Gender
    var favorite : [Place]
    var hostPlace : [Place]
    var bookPlace: [BookPlace]
    var isLogin : Bool
    
}

struct LoginUser : Codable{
    var name : String
    var profileImage : String
    var password : String
    let email : String
    let nickName : String
    let gender : String
}

enum Gender : String, CaseIterable{
    case Male = "남자"
    case Female = "여자"
}
extension User{
    static var currentUser = User(name: "이승원", profileImage: UIImage(named: "tempImage") ?? UIImage(systemName: "person.crop.circle")!, email: "sam98528@naver.com", nickName: "Seungwon", gender: .Male, favorite: Place.fav, hostPlace: Place.host, bookPlace: [BookPlace(place: Place.data[0], time: 3, totalPrice: 9000)], isLogin: true)
    static var profileImageList : [UIImage] = [UIImage(named: "profileImage1")!,UIImage(named: "profileImage2")!,UIImage(named: "profileImage3")!,UIImage(named: "profileImage4")!,UIImage(named: "profileImage5")!,UIImage(named: "profileImage6")!, UIImage(named: "profileImage7")!,]
}


