//
//  Resize.swift
//  BodyCheck
//
//  Created by hyunsubong on 2021/08/08.
//


import SwiftUI

struct Resize: View {
  let imageName: String
  let contentMode: ContentMode
  let renderingMode: Image.TemplateRenderingMode?
  
  init(
    _ imageName: String,
    contentMode: ContentMode = .fill,
    renderingMode: Image.TemplateRenderingMode? = nil
  ) {
    self.imageName = imageName
    self.contentMode = contentMode
    self.renderingMode = renderingMode
  }
  
  var body: some View {
    Image(imageName)
      .renderingMode(renderingMode)
      .resizable()
      .aspectRatio(contentMode: contentMode)
  }
}


// MARK: - Previews

struct ResizedImage_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Resize("apple")
      Resize("apple", contentMode: .fit)
      
      Button(action: {}) {
        Resize("apple")
      }
      Button(action: {}) {
        Resize("apple", renderingMode: .original)
      }
    }
  }
}
