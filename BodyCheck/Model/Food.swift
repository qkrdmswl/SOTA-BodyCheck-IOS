//
//  Food.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/01.
//

import Foundation

 struct Food {
   let name: String
   let imageName: String
   let price: Int
   let description: String
   var isFavorite: Bool = false
 }


 let foodSamples = [
   Food(name: "흰쌀밥", imageName: "rice", price: 3100, description: "2개 먹음"),
   Food(name: "아보카도", imageName: "avocado", price: 2900, description: "~~~~~~~~~~"),
   Food(name: "바나나", imageName: "banana", price: 2400, description: "맛있다.", isFavorite: true),
   Food(name: "피자", imageName: "pizza", price: 3000, description: "맛있다!!!"),
   Food(name: "치킨", imageName: "chicken", price: 3500, description: "치느님", isFavorite: true),
   Food(name: "사과", imageName: "apple", price: 2300, description: "사과다"),
 ]
