//
//  HomeView.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/07/31.
//
// test1


import SwiftUI

struct HomeView: View {
    private enum Tabs {
        case home, chalender, timer, file, myPage
    }
    @State private var selectedTab: Tabs =  .home
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.blue
    }
    // body

    var body: some View {
        TabView(selection: $selectedTab) {
            Group{
                home
                chalender
                timer
                file
                myPage
            }
            .accentColor(.black)
        }
    }
}

private extension HomeView {
    // view
    var home: some View {
        Home()
            .tag(Tabs.home)
            .tabItem(image: "house", text: "홈")
            .onAppear { UITableView.appearance().separatorStyle = .none }
    }

    var chalender: some View {
        ImageView()
            .tag(Tabs.chalender)
            .tabItem(image: "person", text: "캘린더")
    }
    
    var timer: some View {
        StopWatchView()
            .tag(Tabs.chalender)
            .tabItem(image: "timer", text: "측정")
    }

    var file: some View {
        Text("파일")
            .tag(Tabs.file)
            .tabItem(image: "photo.on.rectangle", text: "파일")
    }

    var myPage: some View {
        TestExerciseFoodRead()
            .tag(Tabs.myPage)
            .tabItem(image: "person", text: "마이페이지")
    }
 }

fileprivate extension View {
   func tabItem(image: String, text: String) -> some View {
     self.tabItem {
       Symbol(image, scale: .large)
         .font(Font.system(size: 20, weight: .light))
       Text(text)
     }
   }
 }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
