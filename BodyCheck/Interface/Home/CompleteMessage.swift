//
//  CompletedMessage.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/08.
//

import SwiftUI

struct CompleteMessage: View {
  var body: some View {
    Text("추가 완료!")
      .font(.system(size: 25))
      .bold()
  }
}

struct CompleteMessage_Previews: PreviewProvider {
  static var previews: some View {
    Color.primary.colorInvert()
      .popup(isPresented: .constant(true)) { CompleteMessage() }
      .edgesIgnoringSafeArea(.vertical)
  }
}
