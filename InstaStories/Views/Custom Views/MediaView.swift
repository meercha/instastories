//
//  MediaView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI
import Kingfisher

struct MediaView: View {
  let imageName: String
  @State private var isLoading: Bool = true
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        content(size: geometry.size)
        
        if isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .tint(.white)
        }
      }
      .frame(
        maxWidth: geometry.size.width,
        maxHeight: geometry.size.height
      )
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .contentShape(RoundedRectangle(cornerRadius: 10))
    }
  }
  
  @ViewBuilder private func content(size: CGSize) -> some View {
    if let url = URL(string: imageName) {
      KFImage(url)
        .resizable()
        .onSuccess { _ in
          isLoading = false
        }
        .onFailure { _ in
          isLoading = false
        }
        .onAppear {
          isLoading = true
        }
        .aspectRatio(contentMode: .fill)
        .frame(
          width: size.width,
          height: size.height
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
  }
}
