//
//  Place.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import Foundation
import UIKit

class Place {
    let title : String
    var categories : Categories
    let position : String
    var images : [UIImage]
    var description : String
    var isBooked : Bool
    var rating : Double
    var price : Int
    var x : Double
    var y : Double
    
    init(title: String, categories: Categories, position: String, images: [UIImage], description: String, isBooked: Bool, rating: Double, price: Int, x: Double, y: Double) {
        self.title = title
        self.categories = categories
        self.position = position
        self.images = images
        self.description = description
        self.isBooked = isBooked
        self.rating = rating
        self.price = price
        self.x = x
        self.y = y
    }
}

struct BookPlace {
    var place : Place
    var time : Int
    var totalPrice : Int
}


enum Categories : String, CaseIterable {
    case all = "전체"
    case partyRoom = "파티룸"
    case practiceRoom = "연습실"
    case photoStudio = "촬영스튜디오"
    case studyRoom = "스터디룸"
    case cafe = "카페"
    case gallery = "갤러리"
    case office = "독립오피스"
    case lectureRoon = "강의실"
}

extension Place {
    static var fav: [Place] = [
        Place(title: "가나다", categories: .cafe, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test")!,UIImage(named: "test2")!,UIImage(named: "test2")!,UIImage(named: "test2")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 3.0, price: 9000,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .cafe, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test2")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 4.0, price: 7000,x: 0,y: 0),
        Place(title: "라바사", categories: .gallery, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test4")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 5.0, price: 13000,x: 0,y: 0),
        Place(title: "투투투", categories: .gallery, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test3")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 2.5, price: 15000,x: 0,y: 0),
        Place(title: "아다가", categories: .lectureRoon, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test4")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 3.5, price: 3000,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .office, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test5")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 2.0, price: 4000,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .photoStudio, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test6")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 0.0, price: 2000,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .gallery, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 2.0, price: 3600,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .partyRoom, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test3")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 4.4, price: 7700,x: 0,y: 0),
    ]
    static var host: [Place] = [
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .cafe, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 3.0, price: 9000,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .cafe, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test2")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 4.0, price: 7000,x: 0,y: 0)
    ]
    
    static var data : [Place] = [
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .cafe, position: "서울 서초구 방배동 451-36 지하층",images: [UIImage(named: "test")!,UIImage(named: "test2")!,UIImage(named: "test2")!,UIImage(named: "test2")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 3.0, price: 9000,x: 0,y: 0),
        Place(title: "코딩", categories: .cafe, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test")!,UIImage(named: "test2")!,UIImage(named: "test3")!,UIImage(named: "test4")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 4.0, price: 7000,x: 0,y: 0),
        Place(title: "가나다", categories: .cafe, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 3.0, price: 9000,x: 0,y: 0),
        Place(title: "qwer", categories: .cafe, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test2")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 4.0, price: 7000,x: 0,y: 0),
        Place(title: "라바사", categories: .gallery, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test4")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 5.0, price: 13000,x: 0,y: 0),
        Place(title: "투투투", categories: .gallery, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test3")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 2.5, price: 15000,x: 0,y: 0),
        Place(title: "아다가", categories: .lectureRoon, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test4")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 3.5, price: 3000,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .office, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test5")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 2.0, price: 4000,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .photoStudio, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test6")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 0.0, price: 2000,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .gallery, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 2.0, price: 3600,x: 0,y: 0),
        Place(title: "할인 사당 1분 60평 브라운스톤", categories: .partyRoom, position: "서울 서초구 방배동 451-36 지하층", images: [UIImage(named: "test3")!], description: "아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력\n아무거나 입력아무거나 입력", isBooked: false, rating: 4.4, price: 7700,x: 0,y: 0),
    ]
    static let hourDiscount : Int = 500
    static let eventDiscount : Int = hourDiscount * 4
}

