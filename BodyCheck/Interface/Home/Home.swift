//
//  Home.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/07/31.
//

import SwiftUI

struct Home: View {
    @State var isAdd = false
    @State var message: String = "API 호출 중..."
//    let bucket: Bucket
    var body: some View {
        NavigationView {
            ScrollView() {
                HStack {
                    title
                    topBtn
                }
                Spacer()
            // VStack {
//                HStack(alignment: .top, spacing: 3) {
//                    Text("즐겨찾는 운동")
//                        .font(.headline).fontWeight(.medium)
//                    Symbol("arrowtriangle.down.square")
//                        .padding(2)
//                    Spacer()
//
//                }
//                .padding(.bottom, 20)
//                .padding(.top, 60)
                
                // MARK: 운동 통계
                Text("성중님의").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("8/14 운동 통계").font(.title/*@END_MENU_TOKEN@*/).fontWeight(/*@START_MENU_TOKEN@*/.bold)

                HStack{
                    VStack{
                        Text("달리기")
                        Text("걷기")
                        Text("스쿼트")
                    }
                    ZStack{
                        Rectangle()
                        .fill(Color.gray)
                        .opacity(0.2)
                        .frame(width: 250, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Rectangle()
                        .fill(Color.clear)
                        .opacity(0.3)
                        .frame(width: 230, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        ZStack{
                            VStack(alignment: .leading){
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 230, height: 10)
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 170, height: 10)
                                    .opacity(0.5)
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 100, height: 10)
                                    .opacity(0.5)
                            }
                        }
                        
                    }
                    VStack{
                        Text("2H 32M")
                        Text("1H 50M")
                        Text("1H 03M")
                    }
                }
                
                // MARK: 식단계획
                Text("식단 계획").font(.title/*@END_MENU_TOKEN@*/).fontWeight(/*@START_MENU_TOKEN@*/.bold)
                Text("아침").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
//                FoodRow(food: Food(name: "흰쌀밥", imageName: "rice", kcal: 500, description: "2개 먹음"))
                
                // 아침
                NavigationLink(destination: addUpdate(), isActive: $isAdd) {
                    Button(action: {
                        self.isAdd = true
                    })
                    {
                        Text("아침 식단 추가")
                            .frame(width: 100, height: 10)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                    }
//                    if (self.isAdd == true) {
//                        Button.hidden()
//                    }
                }
                // 점심
                NavigationLink(destination: addUpdate(), isActive: $isAdd) {
                    Button(action: {
                        self.isAdd = true
                        })
                    {
                        Text("점심 식단 추가")
                            .frame(width: 100, height: 10)
                            .padding()
                           .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                   }
                }
//                // 저녁
                NavigationLink(destination: addUpdate(), isActive: $isAdd) {
                    Button(action: {
                        self.isAdd = true
                        })
                    {
                        Text("저녁 식단 추가")
                            .frame(width: 100, height: 10)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                    }
                }
//                .navigationBarHidden(true)
//                FoodRow(food: foodSamples[0])
//                Text("점심").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                FoodRow(food: foodSamples[1])
//                FoodRow(food: foodSamples[2])
            }
//            .navigationTitle("BodyCheck")
//            .navigationBarItems(trailing:
//                HStack {
//                    Button(action: {
//                        print("press alert")
//                    }) { Image(systemName: "bell").imageScale(.large)
//                    }
//
//                    Button(action: {
//                        print("press setting")
//                    }) { Image(systemName: "gear").imageScale(.large)
//                    }
//                }
//            )
        }
        .navigationBarHidden(true)
    }
}

private extension Home {
    var topBtn: some View {
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
    }
    
    var title: some View {
        Text("BodyCheck").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
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
