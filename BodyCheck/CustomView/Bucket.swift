//
//  bucket.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/08.
//

import Foundation

 final class Bucket {
   var foods: [Food]
   
   init(filename: String = "FoodData.json") {
     self.foods = Bundle.main.decode(filename: filename, as: [Food].self)
   }
 }
