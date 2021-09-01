//
//  AddUserProfile.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/09/01.
//

import SwiftUI
import Foundation
import Alamofire

struct ProfileForm: View {
    
    let genderType = ["남성","여성"]
    
    @State var name = ""
    @State var age = ""
    @State var height = ""
    @State var weight = ""
    @ObservedObject var model: PassModel
    @State private var buttonIsDisabled = true
    @State var isPushSuccess = false
    
//    nick, image, age, height, weight, text
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("이름")){
                        TextField("이름을 입력해주세요", text: $name)
                            .keyboardType(.default) //기본 키보드
                    }
                    
                    Section(header: Text("나이")){
                        TextField("이름을 입력해주세요", text: $age)
                            .keyboardType(.default) //기본 키보드
                    }
            
                    Section(header: Text("신장")){
                        TextField("이메일을 입력해주세요", text: $height)
                            .keyboardType(.default)
                    }
                    
                    Section(header: Text("체중")){
                        TextField("이메일을 입력해주세요", text: $weight)
                            .keyboardType(.default)
                    }
                
                                
            }
                NavigationLink(destination: LoginView(), isActive: $isPushSuccess) {
                Button(action: {
//                    AF.request("http://localhost:5001/auth/join", method: .post, parameters: ["email": email, "password": model.$firstEntry], encoding: URLEncoding.httpBody).responseJSON() { response in
//                      switch response.result {
//                      case .success:
//                        if let data = try! response.result.get() as? [String: Any] {
//                            print(data)
//                            self.isJoinSuccess = true
//                        }
//                      case .failure(let error):
//                        print("Error: \(error)")
//                        return
//                      }
//                    }
                    self.isPushSuccess = true
                }) {
                    Text("회원가입")
                }.disabled(buttonIsDisabled || name.isEmpty || age.isEmpty || height.isEmpty || weight.isEmpty)
                    .onReceive(model.submitAllowed) { submitAllowed in
                        self.buttonIsDisabled = !submitAllowed
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue)
                )
                }
            }.navigationBarHidden(true)
        }
    }
}

struct AddUserProfile: View {
    let passform = PassModel()
    var body: some View {
        ProfileForm(model: passform)
    }
}

struct AddUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        AddUserProfile()
    }
}

