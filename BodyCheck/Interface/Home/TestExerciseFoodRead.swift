//
//  TestExerciseFoodRead.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/31.
//

import SwiftUI
import Alamofire

struct PageData: Codable {
    var success: String?
    var message: String?
    var data: [data]?
}

struct data: Codable {
    var id: Int?
    var date: String?
    var startTime: String?
    var endTime: String?
    var memo: String?
    var UserId: Int?
}

struct TestExerciseFoodRead: View {
    var dateFormatter :DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        return formatter
    }
    
    @State private var date = Date()
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var getUserProfile = ""

    var body: some View {
        ScrollView() {

            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .padding(.horizontal)
            .datePickerStyle(GraphicalDatePickerStyle())
            
            Text("\(date)") // 2021-08-31 형식으로 변환할 필요
            VStack {
                Text("운동").font(.title).bold()
                
            }
            
            Button(action: {
                AF.request("http://localhost:5001/dateRecords",
                           method: .get,
                           parameters: ["UserId": 3, "date": "2021-08-31"],
                           encoding: URLEncoding.default,
                           headers: ["Content-Type":"application/json", "Accept":"application/json", "bodycheck-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiZW1haWwiOiJhQGEuYSIsImlhdCI6MTYzMDQyMzk3NCwiZXhwIjoxNjMwNDI3NTc0LCJpc3MiOiJzb3RhIn0.wP9IU5fi5R7jT_Zo8BVEIklqLYWgaqtbLSLfrHJ8vyE"])
                    .validate(statusCode: 200..<300)
                    .responseJSON { (response) in
                        switch response.result {
                        case .success(let obj):
                            if let nsDictionary = obj as? NSDictionary {
                                for (key, value) in nsDictionary {
                                    print("key: \(key), value: \(value)")
                                }
                                let datas = nsDictionary["data"]
                                
                                print("-----------------------")
                                print(datas ?? 1)
                                print("-----------------------")
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                }
            }, label: {
                Text("GET")
                Text("\(self.getUserProfile)")
            })
            
            VStack {
                Text("식단").font(.title).bold()
                
            }
            
            Button(action: {
                AF.request("http://localhost:5001/dateRecords",
                           method: .get,
                           parameters: ["UserId": 3, "date": "2021-08-31"],
                           encoding: URLEncoding.default,
                           headers: ["Content-Type":"application/json", "Accept":"application/json", "bodycheck-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiZW1haWwiOiJhQGEuYSIsImlhdCI6MTYzMDQyMzk3NCwiZXhwIjoxNjMwNDI3NTc0LCJpc3MiOiJzb3RhIn0.wP9IU5fi5R7jT_Zo8BVEIklqLYWgaqtbLSLfrHJ8vyE"])
                    .validate(statusCode: 200..<300)
                    .responseJSON { (response) in
                        switch response.result {
                        case .success(let obj):
                            do {
                                let result = try JSONDecoder().decode([PageData].self, from: obj as! Data)
                                print(result)
                                print("-----------")
                                print(result)
                                print("-----------")
                            }
                            catch(let error) {
                                print(error)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
//                        self.getUserProfile =
//                        print(response)
//                        print(response)
                }
            }, label: {
                Text("GET")
                Text("\(self.getUserProfile)")
            })
            
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
}

//func callCurrentTime() {
//AF.request("API URL. AF.request는 매개변수로 string을 받는다.").responseString() { response in
//                switch response.result {
//                case .success:
//                    self.currentTime = try! response.result.get()
//                case .failure(let error):
//                    print(error)
//                    return
//                }
//            }
//    }

func getTest() {
        AF.request("http://localhost:5001/userProfiles",
                   method: .get,
                   parameters: ["UserId": 3],
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json", "bodycheck-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiZW1haWwiOiJhQGEuYSIsImlhdCI6MTYzMDM4MzY5MSwiZXhwIjoxNjMwMzg3MjkxLCJpc3MiOiJzb3RhIn0.j1-W1E8-PEmbGYP1hrTHEZv1eRDEU1CG9nF4U2yRYas"])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
//                getUserProfile = json
                print(json)
        }
    }

//AF.request("http://localhost:5001/auth/login").responseJSON() { response in
//  switch response.result {
//  case .success:
//    if let data = try! response.result.get() as? [String: Any] {
//        print(data)
//    }
//  case .failure(let error):
//    print("Error: \(error)")
//    return
//  }



struct TestExerciseFoodRead_Previews: PreviewProvider {
    static var previews: some View {
        TestExerciseFoodRead()
    }
}
