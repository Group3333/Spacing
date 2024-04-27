//
//  Place.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import Foundation
import UIKit

class Place {
    var title : String
    var categories : Categories
    var position : String
    var address: String
    var detailAddress: String
    var images : [UIImage]
    var description : String
    var isBooked : Bool
    var rating : Double
    var price : Int
    var lng : Double
    var lat : Double
    
    init(title: String, categories: Categories, position: String, address: String, detailAddress: String, images: [UIImage], description: String, isBooked: Bool, rating: Double, price: Int, lng: Double, lat: Double) {
        self.title = title
        self.categories = categories
        self.position = position
        self.address = address
        self.detailAddress = detailAddress
        self.images = images
        self.description = description
        self.isBooked = isBooked
        self.rating = rating
        self.price = price
        self.lng = lng
        self.lat = lat
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
    case photoStudio = "스튜디오"
    case studyRoom = "스터디룸"
    case cafe = "카페"
    case gallery = "갤러리"
    case office = "오피스"
    case lectureRoom = "강의실"
}


extension Place {
    static var fav: [Place] = [Place.data[0],Place.data[1],Place.data[2]]
    static var host: [Place] = [Place.data[0]]
    
    static var categoryImage : [Categories : UIImage] = [
        .all : UIImage(named: "allImage")!,
        .partyRoom : UIImage(named: "partyRoom")!,
        .practiceRoom : UIImage(named: "practiceRoom")!,
        .photoStudio : UIImage(named: "photoStudio")!,
        .studyRoom : UIImage(named: "studyRoom")!,
        .cafe : UIImage(named: "cafe")!,
        .gallery : UIImage(named: "gallery")!,
        .office : UIImage(named: "office")!,
        .lectureRoom : UIImage(named: "lectureRoom")!
    ]
    
    static let hourDiscount : Int = 500
    static let eventDiscount : Int = hourDiscount * 4
    
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.title == rhs.title && lhs.position == rhs.position
    }
    
}

