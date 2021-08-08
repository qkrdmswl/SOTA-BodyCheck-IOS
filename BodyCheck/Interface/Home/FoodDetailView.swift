//
//  FoodDetailView.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/08.
//

import SwiftUI

struct FoodDetailView: View {
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


private extension FoodDetailView {
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
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        Text(food.name)
          .font(.largeTitle).fontWeight(.medium)
          .foregroundColor(.black)
        
        Spacer()
        
      }
      
      Text(splitText(food.description))
        .foregroundColor(.gray)
        .fixedSize()
    }
  }
  
  var kcalInfo: some View {
    let kcal = quantity * food.kcal
    return HStack {
      (Text("\(kcal)").font(.title)
        + Text(" kcal").font(.title2)
        ).fontWeight(.medium)
      Spacer()
      QuantitySelector(quantity: $quantity)
    }
    .foregroundColor(.black)
  }
  
  var addButton: some View {
    Button(action: {
      self.showingAlert = true
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

struct ProductDetailView_Previews: PreviewProvider {
  static var previews: some View {
    FoodDetailView(food: foodSamples[1])
  }
}
