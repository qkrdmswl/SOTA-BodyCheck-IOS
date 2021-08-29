//
//  Food.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/01.
//

import Foundation

 struct Food {
    var id: UUID = UUID()
    let name: String
    let imageName: String
    let kcal: Int
    let description: String
    var isFavorite: Bool = false
 }

extension Food: Decodable {}
extension Food: Identifiable {}

 var foodSamples = [
   Food(name: "흰쌀밥", imageName: "rice", kcal: 500, description: "2개 먹음"),
   Food(name: "아보카도", imageName: "avocado", kcal: 500, description: "~~~~~~~~~~"),
   Food(name: "바나나", imageName: "banana", kcal: 500, description: "맛있다.", isFavorite: true),
   Food(name: "피자", imageName: "pizza", kcal: 500, description: "맛있다!!!"),
   Food(name: "치킨", imageName: "chicken", kcal: 500, description: "치느님", isFavorite: true),
   Food(name: "사과", imageName: "apple", kcal: 500, description: "사과다"),
 ]
