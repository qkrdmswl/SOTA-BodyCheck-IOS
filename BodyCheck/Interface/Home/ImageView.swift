//
//  ContentView.swift
//  image
//
//  Created by 권성중 on 2021/07/31.
//

import SwiftUI

struct ImageView: View {

    @State private var date = Date()
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()

    var body: some View {
        ScrollView() {

            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .padding(.horizontal)
            .datePickerStyle(GraphicalDatePickerStyle())

            Text("성중님의").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("8/14 운동 통계").font(.title/*@END_MENU_TOKEN@*/).fontWeight(/*@START_MENU_TOKEN@*/.bold)

            HStack{
                VStack{
                    Text("달리기")
                    Text("걷기")
                    Text("스쿼트")
                }
                ZStack{
                    Rectangle()
                    .fill(Color.gray)
                    .opacity(0.2)
                    .frame(width: 250, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Rectangle()
                    .fill(Color.clear)
                    .opacity(0.3)
                    .frame(width: 230, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    ZStack{
                        VStack(alignment: .leading){
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 230, height: 10)
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 170, height: 10)
                                .opacity(0.5)
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 100, height: 10)
                                .opacity(0.5)
                        }
                    }
                    
                }
                VStack{
                    Text("2H 32M")
                    Text("1H 50M")
                    Text("1H 03M")
                }
            }
            Rectangle()
                .fill(Color.white)
                .frame(height:30)

            Text("오늘의 운동 기록")
                .font(.title)
                .fontWeight(.bold)

            Image(uiImage: self.image)
                .resizable()
                .scaledToFit()
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            

            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))

                    Text("사진 / 영상 추가")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
            
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
}
struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
