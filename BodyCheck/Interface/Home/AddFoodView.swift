//
//  AddFoodView.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/29.
//

import SwiftUI

private var g_foodName: String = ""

struct AddFoodView: View {
  let food: Food
  
  @State private var quantity: Int = 1
  @State private var showingAlert: Bool = false
  @State private var showingPopup: Bool = false
  @State private var willAppear: Bool = false
  
    // body
  var body: some View {
    VStack(spacing: 0) {
      if willAppear {
        foodImage
      }
      orderView
    }
    .popup(isPresented: $showingPopup) { CompleteMessage() }
    .edgesIgnoringSafeArea(.top)
    .onAppear { self.willAppear = true }
  }
}

private extension AddFoodView {
    
    // MARK: 식단 사진
  var foodImage: some View {
    let effect = AnyTransition.scale.combined(with: .opacity)
      .animation(Animation.easeInOut(duration: 0.4).delay(0.05))
    return GeometryReader { _ in
      Resize(self.food.imageName)
    }
    .transition(effect)
  }
  var orderView: some View {
    GeometryReader {
      VStack(alignment: .leading) {
        self.foodDescription
        Spacer()
        self.kcalInfo
        self.addButton
      }
      .padding(32)
      .frame(height: $0.size.height + 10)
      .background(Color.white)
      .cornerRadius(16)
      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
    }
  }
    
  var foodDescription: some View {
    // MARK: 식단 정보
    VStack(alignment: .leading, spacing: 16) {
        FoodNameForm()
        FoodDescriptionForm()
        if (self.showingAlert == true) {
            Text("1")
            Text(foodSamples[5].name)
        }
        else {
            Text("0")
        }
    }
  }
    // MARK: 식단 칼로리
  var kcalInfo: some View {
    HStack {
        FoodKcalForm()
        (Text("kcal").font(.title2)).fontWeight(.medium)
    }
    .foregroundColor(.black)
  }

    // MARK: 추가 버튼
  var addButton: some View {
    Button(action: {
      self.showingAlert = true
        foodSamples.append(Food(name: g_foodName, imageName: "rice", kcal: 500, description: "2개 먹음"))
    }) {
      Capsule()
        .fill(Color.blue)
        .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
        .overlay(Text("추가하기")
          .font(.system(size: 20)).fontWeight(.medium)
          .foregroundColor(Color.white))
        .padding(.vertical, 8)
    }
    .buttonStyle(ShrinkButtonStyle())
  }
  
  func splitText(_ text: String) -> String {
    guard !text.isEmpty else { return text }
    let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
    let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ")
      ?? text[centerIdx...].firstIndex(of: " ")
      ?? text.index(before: text.endIndex)
    let afterSpaceIdx = text.index(after: centerSpaceIdx)
    let lhsString = text[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
    let rhsString = text[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)
    return String(lhsString + "\n" + rhsString)
  }
}

// MARK: Form
struct FoodNameForm: View {
    @State var foodName = ""
    var body: some View {
        HStack{
            Text("이름")
            TextField("여기에 입력하세요.", text: $foodName)
                            .frame(width: 200, height: 5)
                            .padding()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct FoodDescriptionForm: View {
    @State var foodDescription = ""
    var body: some View {
        HStack{
            Text("설명")
            TextField("여기에 입력하세요.", text: $foodDescription)
                .frame(width: 200, height: 5.0)
                .padding()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct FoodKcalForm: View {
    @State var foodKcal: String = ""
    var body: some View {
        HStack{
            TextField("칼로리", text: $foodKcal)
                .frame(width: 100, height: 20)
                .padding()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

// MARK: PreView
struct AddFoodView_Previews: PreviewProvider {
  static var previews: some View {
    AddFoodView(food: foodSamples[1])
  }
}
