//
//  ShrinkButtonStyle.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/08.
//

import SwiftUI

struct ShrinkButtonStyle: ButtonStyle {
  var minScale: CGFloat = 0.9
  var minOpacity: Double = 0.6
  
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? minScale : 1)
      .opacity(configuration.isPressed ? minOpacity : 1)
  }
}


// MARK: - Previews

struct ShrinkButtonStyle_Previews: PreviewProvider {
  static var previews: some View {
    Button(action: {}) {
      Text("Button")
        .padding()
        .padding(.horizontal)
        .background(Capsule().fill(Color.yellow))
    }
    .buttonStyle(ShrinkButtonStyle())
  }
}
