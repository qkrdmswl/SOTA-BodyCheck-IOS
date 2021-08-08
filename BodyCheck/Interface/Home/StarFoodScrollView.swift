////
////  StarFoodScrollView.swift
////  BodyCheck
////
////  Created by hyunsubong on 2021/08/08.
////
//
//import SwiftUI
//
//struct StarFoodScrollView: View {
////    @EnvironmentObject private var food: Food
//  @Binding var showingImage: Bool
//
//  var body: some View {
//    VStack(alignment: .leading) {
//      title
//
//      if showingImage {
////        foods
//      }
//    }
//    .padding()
//    .transition(.slide)
//  }
//}
//
//
//private extension StarFoodScrollView {
//  // MARK: View
//
//  var title: some View {
//    HStack(alignment: .top, spacing: 5) {
//      Text("즐겨찾는 상품")
//        .font(.headline).fontWeight(.medium)
//
//      Symbol("arrowtriangle.up.square")
//        .padding(4)
//        .rotationEffect(Angle(radians: showingImage ? .pi : 0))
//
//      Spacer()
//    }
//    .padding(.bottom, 8)
//    .onTapGesture {
//      withAnimation { self.showingImage.toggle() }
//    }
//  }
//
//  var products: some View {
//    let favoriteProducts = food.foods.filter { $0.isFavorite }
//    return ScrollView(.horizontal, showsIndicators: false) {
//      HStack(spacing: 0) {
//        ForEach(favoriteProducts) { product in
//            NavigationLink(destination: FoodDetailView(food: food)) {
//            self.eachProduct(food)
//          }
//        }
//      }
//    }
//    .animation(.spring(dampingFraction: 0.78))
//  }
//
//  func eachProduct(_ food: Food) -> some View {
//    GeometryReader { g in
//      VStack {
//        Resize(food.imageName, renderingMode: .original)
//          .clipShape(Circle())
//          .frame(width: 90, height: 90)
//          .scaleEffect(self.scaledValue(from: g))
//      }
//      .position(x: g.size.width / 2, y: g.size.height / 2)
//    }
//    .frame(width: 105, height: 105)
//  }
//
//  // MARK: Computed Values
//
//  func scaledValue(from geometry: GeometryProxy) -> CGFloat {
//    let xOffset = geometry.frame(in: .global).minX - 16
//    let minSize: CGFloat = 0.9
//    let maxSize: CGFloat = 1.1
//    let delta: CGFloat = maxSize - minSize
//    let size = minSize + delta * (1 - xOffset / UIScreen.main.bounds.width)
//    return max(min(size, maxSize), minSize)
//  }
//}
//
//struct StarFoodScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        StarFoodScrollView(showingImage: .constant(true))
//    }
//}
