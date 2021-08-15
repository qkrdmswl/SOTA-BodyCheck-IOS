//
//  Home.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/07/31.
//

import SwiftUI

struct Home: View {
//    let bucket: Bucket
    var body: some View {
        NavigationView {
            
//            List(bucket.foods) { food in
//                     NavigationLink(destination: Text("상세 정보")) {
//                       FoodRow(food: food)
//                     }
//                   }
            ScrollView() {
            // VStack {
                HStack(alignment: .top, spacing: 3) {
                    Text("즐겨찾는 운동")
                        .font(.headline).fontWeight(.medium)
                    Symbol("arrowtriangle.down.square")
                        .padding(2)
                    Spacer()

                }
                .padding(.bottom, 20)
                .padding(.top, 60)

                HStack {
                    Text("운동 통계")
                        .font(.title3).fontWeight(.medium)
                    Spacer()
                }
                .padding(.bottom, 20)
                
                HStack {
                    Text("식단 계획")
                        .font(.title3).fontWeight(.medium)
                    Spacer()
                }
                .padding(.bottom, 20)

                HStack {
                    Text("최근 식단")
                        .font(.title3).fontWeight(.medium)
                    Spacer()
                }
                .padding(.bottom, 20)

                FoodRow(food: foodSamples[0])
                FoodRow(food: foodSamples[1])
                FoodRow(food: foodSamples[2])
            }
            .navigationTitle("BodyCheck")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        print("press alert")
                    }) { Image(systemName: "bell").imageScale(.large)
                    }
                    
                    Button(action: {
                        print("press setting")
                    }) { Image(systemName: "gear").imageScale(.large)
                    }
                }
            )
        }
    }
}

//struct SomeView: View {
//    var body: some View {
//        HStack(alignment: .top, spacing: 5) {
//            Text("즐겨찾는 운동")
//                .font(.headline).fontWeight(.medium)
//            Symbol("arrowtriangle.up.square")
//                .padding(4)
//            Spacer()
//
//        }
//        .padding(.bottom, 8)
////        .onTapGesture {
////            withAnimation { self.showingImage.toggle() }
////        }
//    }
//}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
//        Home(bucket: <#T##Bucket#>)
        Home()
    }
}
