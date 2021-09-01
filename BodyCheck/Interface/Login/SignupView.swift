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
    
    @State var name = ""
    @State var email = ""
    @ObservedObject var model: PassModel
    @State private var buttonIsDisabled = true
    @State var isJoinSuccess = false
    
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("이름")){
                        TextField("이름을 입력해주세요", text: $name)
                            .keyboardType(.default) //기본 키보드
                    }
                    
                    Section(header: Text("이메일")){
                        TextField("이메일을 입력해주세요", text: $email)
                            .keyboardType(.default)
                    }
                    
                    Section(header: Text("비밀번호")){
                        SecureField("비밀번호를 입력해주세요", text: $model.firstEntry)
                            .keyboardType(.default)
                    }
                    
                    Section(header: Text("비밀번호 확인")){
                        SecureField("비밀번호 한번 더 입력", text: $model.secondEntry)
                            .keyboardType(.default)
                    }
                
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
            }
                NavigationLink(destination: LoginView(), isActive: $isJoinSuccess) {
                Button(action: {
                    AF.request("http://localhost:5001/auth/join", method: .post, parameters: ["email": email, "password": model.firstEntry], encoding: URLEncoding.httpBody, headers: ["bodycheck-client-secret": "bodycheck_client_secret_sota"]).responseJSON() { response in
                      switch response.result {
                      case .success:
                        if let data = try! response.result.get() as? [String: Any] {
                            print(data)
                            self.isJoinSuccess = true
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
//                  .padding(.vertical, 1)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue)
                )
                }
            }.navigationBarHidden(true)
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
