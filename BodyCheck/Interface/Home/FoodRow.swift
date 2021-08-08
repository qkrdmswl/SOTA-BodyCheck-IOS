//
//  FoodRow.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/07/31.
//

import SwiftUI

struct FoodRow: View {
    @State private var willAppear: Bool = false
    let food: Food
    
    var body: some View {
        HStack {
            foodImage
            foodDescription
        }
        .frame(height: 150)
        .background(Color.primary.colorInvert())
        .cornerRadius(15)
        .shadow(color: .gray, radius: 5, x: 2, y: 2)
        .padding(.vertical, 3)
        .padding(.horizontal, 9)
        .opacity(willAppear ? 1 : 0)
        .animation(.easeInOut(duration: 0.4))
        .onAppear { self.willAppear = true }
    }
}

private extension FoodRow {
    
    var foodImage: some View {
        Image(food.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }

    var foodDescription: some View {
        VStack(alignment: .leading) {
            Text(food.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 1)

            Text(food.description)
                .font(.footnote)
                .foregroundColor(.secondary)

            Spacer()

            footerView
        }
        .padding([.leading, .bottom], 10)
        .padding([.top, .trailing])
    }

    var footerView: some View {
        HStack(spacing: 0) {
            Text("500").font(.headline)
                + Text(" kcal").font(.footnote)

            Spacer()

            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(.secondary)
                .frame(width: 30, height: 30)

            Image(systemName: "plus")
                .foregroundColor(.secondary)
                .frame(width: 30, height: 30)
        }
    }
}

struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodRow(food: foodSamples[0])
    }
}
