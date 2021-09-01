//
//  AddExerciseView.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/30.
//

import SwiftUI
import Alamofire

struct AddExerciseView: View {
  
    @State private var showingAlert: Bool = false
    @State private var showingPopup: Bool = false
    @State private var willAppear: Bool = false
    @State private var isPushSuccess1: Bool = false
    @State private var isPushSuccess2: Bool = false
    @State private var isPushSuccess3: Bool = false
    
    @State var exerciseName: String = ""
    @State var exerciseWeight: String = ""
    @State var exerciseCount: String = ""
    @State var exerciseSet: Int = 0
    
    // MARK: 바디 & 버튼
  var body: some View {
    VStack(spacing: 0) {
      if willAppear {
        exerciseImage
      }
      orderView
    }
    .popup(isPresented: $showingPopup) { CompleteMessage() }
    .edgesIgnoringSafeArea(.top)
    .onAppear { self.willAppear = true }
  }
}

private extension AddExerciseView {
    
    // MARK: 운동 사진
  var exerciseImage: some View {
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
        ExerciseNameForm(exerciseName: $exerciseName)
        ExerciseWeightForm(exerciseWeight: $exerciseWeight)
        ExerciseCountForm(exerciseCount: $exerciseCount)
        ExerciseSetForm(exerciseSet: $exerciseSet)
    }
  }

    // MARK: 추가 버튼
    // 단순 운동명 추가 = exercise(이름)
    // 기록포함 = exercise(이름) -> variable(무게,시간 등, 타입, ExerciseId) -> dateRecord -> record
  var addButton: some View {
    Button(action: {
        self.showingAlert = true
        print("성공!")
        print(exerciseName)
        print(exerciseWeight)
        print(exerciseCount)
        print(exerciseSet)
        
        // MARK: 운동
        AF.request("http://localhost:5001/exercise", method: .post, parameters: ["name": exerciseName, "UserId": 5], encoding: URLEncoding.httpBody, headers: ["bodycheck-client-secret": "bodycheck_client_secret_sota"]).responseJSON() { response in
          switch response.result {
          case .success(let obj):
              if let nsDictionary = obj as? NSDictionary {
                  for (key, value) in nsDictionary {
                    let keyData: String = key as! String
                    if (keyData == "success" && value as! Bool == true) {
                        print("성공!")
                        self.isPushSuccess1 = true
                    }
                  }
              }
          case .failure(let error):
              print(error.localizedDescription)
          }
        }
        // MARK: 운동변수
        AF.request("http://localhost:5001/variable", method: .post, parameters: ["name": "시간", "VariableTypeId": 3, "ExerciseId": 1], encoding: URLEncoding.httpBody, headers: ["bodycheck-client-secret": "bodycheck_client_secret_sota"]).responseJSON() { response in
          switch response.result {
          case .success(let obj):
              if let nsDictionary = obj as? NSDictionary {
                  for (key, value) in nsDictionary {
                    let keyData: String = key as! String
                    if (keyData == "success" && value as! Bool == true) {
                        print("성공!")
                        self.isPushSuccess2 = true
                    }
                  }
              }
          case .failure(let error):
              print(error.localizedDescription)
          }
        }
        
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
    @Binding var exerciseName: String
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
    @Binding var exerciseWeight: String
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
    @Binding var exerciseCount: String
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
    @Binding var exerciseSet: Int
    @State private var quantity: Int = 1
    var body: some View {
        let set = quantity
        return HStack {
            Text("세트    ")
            Text("\(set)").font(.title).fontWeight(.medium)
                Spacer()
                QuantitySelector(quantity: $quantity)
              }
              .foregroundColor(.black)
    }
}

// MARK: PreView
struct AddExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    AddExerciseView()
  }
}
