//
//  Home.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/07/31.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("운동통계")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(.bottom, 1)
                Text("식단")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(.bottom, 1)
                FoodRow(food: foodSamples[0])
                FoodRow(food: foodSamples[2])
                FoodRow(food: foodSamples[3])
            }
            .navigationTitle("BodyCheck")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
