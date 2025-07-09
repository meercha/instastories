//
//  StoryStatusView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

struct StoryStatusView: View {
  let seen: Bool
  let metric: CGFloat = 78
  
  var body: some View {
    Circle().stroke(gradient(seen), lineWidth: metric * 0.035)
  }
  
  private func gradient(_ seen: Bool) -> LinearGradient {
    LinearGradient(
      colors: seen
      ? [.black.opacity(0.15)]
      : [
        Color.yellow,
        Color(red: 0.984, green: 0.745, blue: 0.164),  // Yellow-Orange
        Color(red: 0.992, green: 0.380, blue: 0.243),  // Orange-Red
        Color(red: 0.867, green: 0.174, blue: 0.482),  // Magenta-Pink
        Color.pink,
      ],
      startPoint: .bottomLeading,
      endPoint: .topTrailing
    )
  }
}
