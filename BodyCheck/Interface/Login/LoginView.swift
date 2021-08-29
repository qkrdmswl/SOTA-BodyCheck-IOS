//
//  LoginView.swift
//  BodyCheckApp2
//
//  Created by 언지 on 2021/07/25.
//

import SwiftUI
import Alamofire

struct LoginView: View {
    
    @State var isLinkActive = false
    @State var message: String = "API 호출 중..."
    
    var body: some View {
        NavigationView {
            VStack {
                // 타이틀
                AppTitle()
                Spacer()
                EmailForm()
                PasswordForm()
//                LoginAction()
                HStack {
                    ToggleView()
                    // 밑에 안씀
                    NavigationLink(destination: HomeView(), isActive: $isLinkActive) {
                        Button(action: {
                            self.isLinkActive = true
                        }) {
                            Text("로그인")
                                .frame(width: 80, height: 10)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                            }
                        }
                }
                // MARK: API
                Button(action: {
                    AF.request("http://localhost:5001/auth/login", method: .post, parameters: ["email": "a@a.a", "password": "a"], encoding: URLEncoding.httpBody, headers: ["bodycheck-client-secret": "bodycheck_client_secret_sota"]).responseJSON() { response in
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
                    self.isLinkActive = true
                }) {
                    Text("api 테스트 - POST")
                        .frame(width: 150, height: 10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                }
                
                Button(action: {
                    AF.request("http://localhost:5001/auth/login").responseJSON() { response in
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
                    self.isLinkActive = true
                }) {
                    Text("api 테스트 - GET")
                        .frame(width: 150, height: 10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                }
                
                Spacer()
                
                HStack (spacing: 20){
                    NavigationLink(
                        destination: FindAccountView(),
                        label: {
                            Text("계정찾기")
                    })
                    NavigationLink(
                        destination: SignupView(),
                        label: {
                            Text("회원가입")
                    })
                }.padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct AppTitle: View {
    var body: some View {
        VStack {
            Text("Body Check")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.blue)
        }
//        .frame(maxHeight: 250, alignment: .center)
    }
}

struct EmailForm: View {
    @State var emailAddress = ""
    var body: some View {
        HStack{
            Text("ID")
            TextField("아이디/이메일", text: $emailAddress)
                .foregroundColor(.gray)
                .frame(width: 250, height: 20)
                .padding()
        }
        .textFieldStyle(OvalTextFieldStyle())
        .padding(.bottom, 10)
    }
}

struct PasswordForm: View {
    @State private var password: String = ""
    var body: some View {
        HStack{
            Text("PW")
            SecureField("비밀번호", text: $password)
                .frame(width: 250, height: 20)
                .padding()
        }
        .textFieldStyle(OvalTextFieldStyle())
        .padding(.bottom, 10)
        .padding(.trailing, 10)
    }
}

struct LoginAction: View {
    @State private var isOn = true
    @State var isLinkActive = false
    
    init() {
        UISwitch.appearance().onTintColor = .gray
        UISwitch.appearance().thumbTintColor = .white
    }
    
    var body: some View {
        HStack {
            ToggleView()
            Button(action: { }) {
                Text("로그인")
                    .frame(width: 80, height: 10)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
        }.padding()
    }
}

struct ToggleView: View {
    @State var toggleIsOn: Bool = false
    var body: some View {
        Toggle(isOn: $toggleIsOn, label: {
            Text("자동")
        })
        .frame(width: 90, height: 40)
        .toggleStyle(SwitchToggleStyle.init(tint: Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))))
        .padding()
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color("general"), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)
    }
}
