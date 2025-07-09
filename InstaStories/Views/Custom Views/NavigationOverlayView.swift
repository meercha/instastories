//
//  NavigationOverlayView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

struct NavigationOverlayView: View {
  @Binding var progress: CGFloat
  var count: Int
  var action: (_ moveForward: Bool) -> Void
  
  var body: some View {
    HStack {
      Rectangle()
        .fill(Color.black.opacity(0.01))
        .onTapGesture {
          if (progress - 1) < 0 {
            action(false)
          } else {
            // update to next story
            self.progress = CGFloat(Int(progress - 1))
          }
        }
      
      Rectangle()
        .fill(Color.black.opacity(0.01))
        .onTapGesture {
          // Checking and updateing to next
          if (progress + 1) > CGFloat(count) {
            action(true)
          } else {
            // update to next story
            self.progress = CGFloat(Int(progress + 1))
          }
        }
    }
  }
}
