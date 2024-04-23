//
//  File.swift
//  Spacing
//
//  Created by 서혜림 on 4/22/24.
//

import Foundation
import UIKit

class Place {
  let title : String
  var categories : [Categories]
  let position : String
  var images : [UIImage]
  var description : String
  var isBooked : Bool
  init(title: String, position: String, images: [UIImage], description: String, isBooked: Bool, categories: [Categories]) {
    self.title = title
    self.position = position
    self.images = images
    self.description = description
    self.isBooked = isBooked
    self.categories = categories
  }
}

enum Categories : String, CaseIterable {
    case partyRoom = "파티룸"
    case practiceRoom = "연습실"
    case photoStudio = "촬영스튜디오"
    case studyRoom = "스터디룸"
    case cafe = "카페"
    case gallery = "갤러리"
    case office = "독립오피스"
    case lectureRoon = "강의실"
}
