//
//  HomeView.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/07/31.
//

import SwiftUI

struct HomeView: View {
    private enum Tabs {
        case home, chalender, file, myPage
    }
    @State private var selectedTab: Tabs =  .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group{
                home
                chalender
                file
                myPage
            }
//            .accentColor(.primary)
        }
//        .accentColor(.peach)
//        .edgesIgnoringSafeArea(.top)
    }
}

private extension HomeView {
   // MARK: View
   
    var home: some View {
        Home()
            .tag(Tabs.home)
            .tabItem(image: "house", text: "홈")
    }
    
    var chalender: some View {
        Text("마이페이지")
            .tag(Tabs.chalender)
            .tabItem(image: "person", text: "캘린더")
    }
    
    var file: some View {
        Text("마이페이지")
            .tag(Tabs.file)
            .tabItem(image: "person", text: "파일")
    }

    var myPage: some View {
        Text("마이페이지")
            .tag(Tabs.myPage)
            .tabItem(image: "person", text: "마이페이지")
    }
 }

fileprivate extension View {
   func tabItem(image: String, text: String) -> some View {
     self.tabItem {
//       Symbol(image, scale: .large)
//         .font(Font.system(size: 17, weight: .light))
       Text(text)
     }
   }
 }

struct SomeView: View {
    var body: some View {
        VStack {
            Text("임시 페이지")
        }.font(.title)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
