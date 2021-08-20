//
//  FindAccountView.swift
//  BodyCheckApp2
//
//  Created by 언지 on 2021/07/25.
//

import SwiftUI
import Combine


struct FindAccountForm: View {
    let genderType = ["남성","여성"]
    
    @State var email = ""
    @State var checkNum = ""
//    @State var newPwd = ""
    @State var clickCheck = false
    @State var userCheck = false
    @ObservedObject var model: PassModel
    @State private var buttonIsDisabled = true
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
    }()
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    VStack{
                        HStack{ // 아이디도 가능?
                            TextField("이메일을 입력해주세요", text: $email)
                                .keyboardType(.default)
                            
                            Button(action: {
                                self.clickCheck.toggle()
                            }) {
                                Text("인증번호 전송")
                            }.disabled(email.isEmpty)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue)
                            )
                        }
//                        Section(header: Text("인증번호 입력")){
//                            TextField("인증번호 입력", value: $checkNum, formatter: formatter)
//                                .keyboardType(.default)
//                        }.hidden()
//                        .padding(.top, 10)
                        if self.clickCheck {
                            Text("인증번호가 전송되었습니다.")
                            TextField("인증번호 입력", text: $checkNum)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                            
                            if (!checkNum.isEmpty){
                                Button(action: {
                                    self.userCheck.toggle()
                                }) {
                                    Text("확인")
                                }.disabled(checkNum.isEmpty)
                                .padding()
                                .frame(width: 50, height: 30)
                                .font(.system(size: 10))
                                .background(RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.blue)
                                )
                            }
                        }
                        if self.userCheck{
                            Text("사용자 인증 완료")
                        }
                    }
                    
                    Section(header: Text("비밀번호 재설정")){
                        TextField("비밀번호 재설정", text: $model.firstEntry)
                            .keyboardType(.default)
                        TextField("비밀번호 확인", text: $model.secondEntry)
                            .keyboardType(.default)
                        
                    }.disabled(!userCheck)
                    
                    VStack {
                        ForEach(model.validationMessages, id: \.self) { msg in
                          HStack {
                            Spacer()
                            Text(msg)
                                .foregroundColor(.red)
                            Spacer()
                          }
                        }
                        
                        Button(action: {}) {
                            Text("비밀번호 변경 완료")
                        }.disabled(buttonIsDisabled)
                            .onReceive(model.submitAllowed) { submitAllowed in
                                self.buttonIsDisabled = !submitAllowed
                        }
                        .frame(alignment: .center)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue)
                        )
                    }
                    
                    
                }.padding(.top, 5)
                
            
                
                
                
                    
            }.navigationBarTitle("계정찾기")
                
                Spacer()
                                
            }
        }
            
    }


struct FindAccountView: View {
    let passform = PassModel()
    var body: some View {
        FindAccountForm(model: passform)
    }
}


struct FindAccountView_Previews: PreviewProvider {
    static var previews: some View {
        FindAccountView()
    }
}

