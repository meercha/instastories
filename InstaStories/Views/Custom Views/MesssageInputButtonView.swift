//
//  MesssageInputButtonView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

struct MesssageInputButtonView: View {
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text("Send message...")
        .font(.system(size: 16)).bold()
        .foregroundColor(.white)
        .padding(.vertical, 14)
        .padding(.horizontal, 22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
          Capsule()
            .stroke(.white, lineWidth: 0.3)
            .padding(2)
        }
    }
  }
}
