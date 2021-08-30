//
//  AddExerciseView.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/30.
//

import SwiftUI

private var g_foodName: String = ""

struct AddExerciseView: View {
  
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

private extension AddExerciseView {
    
    // MARK: 식단 사진
  var foodImage: some View {
    let effect = AnyTransition.scale.combined(with: .opacity)
      .animation(Animation.easeInOut(duration: 0.4).delay(0.05))
    return GeometryReader { _ in
    }
    .transition(effect)
  }
  var orderView: some View {
    GeometryReader {
      VStack(alignment: .leading) {
        self.exerciseInfo
        Spacer()
        self.weightInfo
        self.addButton
      }
      .padding(32)
      .frame(height: $0.size.height + 10)
      .background(Color.white)
      .cornerRadius(16)
      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
    }
  }
    
  var exerciseInfo: some View {
    // MARK: 운동 정보
    VStack(alignment: .leading, spacing: 16) {
        ExerciseNameForm()
        ExerciseWeightForm()
        ExerciseCountForm()
        ExerciseSetForm()
    }
  }
    // MARK: 무게
  var weightInfo: some View {
    HStack {
        ExerciseWeightForm()
        (Text("kcal").font(.title2)).fontWeight(.medium)
    }
    .foregroundColor(.black)
  }

    // MARK: 추가 버튼
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

// MARK: Form
struct ExerciseNameForm: View {
    @State var exerciseName = ""
    var body: some View {
        HStack{
            Text("이름")
            TextField("여기에 입력하세요.", text: $exerciseName)
                            .frame(width: 200, height: 5)
                            .padding()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ExerciseWeightForm: View {
    @State var exerciseWeight = ""
    var body: some View {
        HStack{
            Text("무게")
            TextField("여기에 입력하세요.", text: $exerciseWeight)
                .frame(width: 200, height: 5.0)
                .padding()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ExerciseCountForm: View {
    @State var exerciseCount = ""
    var body: some View {
        HStack{
            Text("횟수")
            TextField("여기에 입력하세요.", text: $exerciseCount)
                .frame(width: 200, height: 5.0)
                .padding()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ExerciseSetForm: View {
    @State var exerciseSet: String = ""
    @State private var quantity: Int = 1
    var body: some View {
        let set = quantity
        return HStack {
            Text("세트    ")
            Text("\(set)").font(.title).fontWeight(.medium).hidden()
                Spacer()
                QuantitySelector(quantity: $quantity)
              }
              .foregroundColor(.black)
//        HStack{
//            Text("세트")
//            TextField("여기에 입력하세요", text: $exerciseSet)
//                .frame(width: 200, height: 5)
//                .padding()
//        }
//        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

// MARK: PreView
struct AddExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    AddExerciseView()
  }
}
