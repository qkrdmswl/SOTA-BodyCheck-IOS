//
//  addUpdate.swift
//  BodyCheckApp2
//
//  Created by 언지 on 2021/08/15.
//

import SwiftUI

// 페이지 의도..?
// 1. 그동안 한 운동 목록 & 식단 띄워주기 + 추가 수정 용도
// 2. 수정한 내용은 어디에 반영?

struct addUpdate : View {
    @State var exercise = ["데드리프트", "벤치프레스", "달리기"]  // 여기에 데이터 받아서 저장
    @State var meal = ["사과", "아보카도", "계란"]  // 식단도 마찬가지로
    
    var body: some View {
        NavigationView {
            // MARK: 리스트
            List {
                Section(header: Text("운동")){
                    ForEach(exercise, id: \.self) { exercise in
                        Text(exercise)
                    }
                    .onMove(perform: move)
                }
                
                Section(header: Text("식단")){
                    ForEach(meal, id: \.self) { meal in
                        Text(meal)
                    }
                    .onMove(perform: move)
                }
                
                Section(header: Text("테스트")){
                    ForEach(foodSamples) {
                        obj in Text(obj.name)
                    }
//                    .onMove(perform: move)
                }
                
            }
            // MARK: 네비게이션
            .navigationBarItems(
                trailing:
                HStack {
                    EditButton()
                    NavigationLink(destination:
                        AddExerciseView()) {
                        Text("운동 추가")
                    }
                    NavigationLink(destination: AddFoodView(food: foodSamples[1])) {
                        Text("식단 추가")
                    }
                }
            )
        }
        .navigationBarHidden(true)
    }

    func move(from source: IndexSet, to destination: Int) {
        let reversedSource = source.sorted()

        for index in reversedSource.reversed() {
            exercise.insert(exercise.remove(at: index), at: destination)
        }
    }
}

struct addUpdate_Previews: PreviewProvider {
    static var previews: some View {
        addUpdate()
    }
}


struct TaskRow:View {
    var body: some View {
        Text("Task item")
    }
}
