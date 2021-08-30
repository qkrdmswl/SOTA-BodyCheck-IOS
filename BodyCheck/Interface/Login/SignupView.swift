//
//  SignupView.swift
//  BodyCheckApp2
//
//  Created by 언지 on 2021/07/25.
//

import SwiftUI
import Foundation
import Alamofire

struct SignupForm: View {
    
    let genderType = ["남성","여성"]
    
    @State var name = ""
    @State var gender = 0
    @State var age = 0
    @State var email = ""
    @ObservedObject var model: PassModel
    @State private var buttonIsDisabled = true
    
    
    var body: some View {
//        NavigationView{
            VStack{
                Form{
                    Section(header: Text("이름")){
                        TextField("이름을 입력해주세요", text: $name)
                            .keyboardType(.default) //기본 키보드
                    }
                    
                    Section(header: Text("생년월일")){
                        //선택하는 값을 bornIn 변수에 할당
                        Picker("출생년도",selection: $age){
                            // 1900부터 2021까지
                            ForEach((1900...2021).reversed(), id: \.self ){
                                Text("\(String($0))년생")
                            }
                        }
                    }
                    
                
                    Section(header: Text("성별")){
                        //선택하는 값을 bornIn 변수에 할당합니다.
                        Picker("성별",selection: $gender){
                            // 1900부터 2021까지 Text를 만듭니다.
                            ForEach( 0  ..< genderType.count ){
                                Text("\(self.genderType[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    Section(header: Text("이메일")){  // 중복허용?
                        TextField("이메일을 입력해주세요", text: $email)
                            .keyboardType(.default)
                    }
                    
                    Section(header: Text("비밀번호")){  // 중복허용?
                        SecureField("비밀번호를 입력해주세요", text: $model.firstEntry)
                            .keyboardType(.default)
                    }
                    
                    Section(header: Text("비밀번호 확인")){  // 중복허용?
                        SecureField("비밀번호 한번 더 입력", text: $model.secondEntry)
                            .keyboardType(.default)
                    }
                    
//                }.navigationBarTitle("회원가입")
                
                VStack {
                    ForEach(model.validationMessages, id: \.self) { msg in
                      HStack {
                        Spacer()
                        Text(msg)
                            .foregroundColor(.red)
                        Spacer()
                      }
                    }
                }
                
                Button(action: {
                    AF.request("http://localhost:5001/auth/join", method: .post, parameters: ["email": email, "password": model.$firstEntry], encoding: URLEncoding.httpBody).responseJSON() { response in
                      switch response.result {
                      case .success:
                        if let data = try! response.result.get() as? [String: Any] {
                            print(data)
                        }
                      case .failure(let error):
                        print("Error: \(error)")
                        return
                      }
                    }
                }) {
                    Text("회원가입")
                }.disabled(buttonIsDisabled || email.isEmpty || name.isEmpty)
                    .onReceive(model.submitAllowed) { submitAllowed in
                        self.buttonIsDisabled = !submitAllowed
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue)
                )
                Spacer()
                                
            }
        }
            
    }
}

struct SignupView: View {
    let passform = PassModel()
    var body: some View {
        SignupForm(model: passform)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
