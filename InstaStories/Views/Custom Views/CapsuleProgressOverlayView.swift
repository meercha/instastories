//
//  CapsuleProgressOverlayView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

struct CapsuleProgressOverlayView: View {
  @Binding var progress: CGFloat
  let range: Range<Int>
  
  var body: some View {
    HStack(spacing: 5) {
      ForEach(Array(range), id: \.self) { index in
        GeometryReader { proxy in
          
          let width = proxy.size.width
          let progress = progress - CGFloat(index)
          let perfectProgress = min(max(progress, 0), 1)
          
          Capsule()
            .fill(.gray.opacity(0.5))
            .overlay(alignment: .leading) {
              Capsule()
                .fill(.white)
                .frame(width: width * perfectProgress)
            }
        }
      }
    }
    .frame(height: 1.4)
    .padding(.horizontal)
  }
}
