//
//  HeartButtonView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

public struct HeartButtonView: View {
  let action: () -> Void
  let liked: Bool
  
  public var body: some View {
    Button(action: action) {
      GeometryReader { proxy in
        heart()
      }
      .aspectRatio(contentMode: .fit)
    }
  }
  
  @ViewBuilder
  private func heart() -> some View {
    Image(systemName: liked ? "heart.fill" : "heart")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .font(.system(size: 24, weight: .regular))
      .tint(liked ? .red : .white)
      .frame(height: 20)
  }
}

#Preview {
  HeartButtonView(action: {}, liked: true)
}
