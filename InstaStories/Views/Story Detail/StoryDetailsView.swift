//
//  StoryDetailsView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI
import Kingfisher

struct StoryDetailsView: View {
  let storyBundle: StoryBundle
  let story: Story
  let onClose: () -> Void
  
  var body: some View {
    if let url = URL(string: storyBundle.profileImage) {
      HStack(spacing: 0) {
        KFImage(url)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 32, height: 32)
          .clipShape(Circle())
          .padding(.trailing, 8)
        
        VStack(alignment: .leading) {
          Text("\(storyBundle.profileName) ").bold()
          + Text("1h")
            .foregroundStyle(.white.opacity(0.8))
          
          if let band = story.band, let song = story.song {
            HStack {
              Image(systemName: "waveform")
                .symbolEffect(.variableColor.dimInactiveLayers.cumulative.reversing)
              Text(band).bold() + Text(" ∙ ") + Text(song)
            }
          }
        }
        .font(.system(size: 14))
        .multilineTextAlignment(.leading)
        .foregroundStyle(.white)
        
        Spacer()
        
        Button(action: {}) {
          Image(systemName: "ellipsis")
            .imageScale(.medium)
            .tint(.white)
        }
        .padding(12)
        .contentShape(Circle())
        
        Button(action: { onClose() }) {
          Image(systemName: "xmark")
            .imageScale(.large)
            .tint(.white)
        }
        .padding(4)
        .padding(.trailing, 8)
        .contentShape(Circle())
      }
      .padding(.leading, 16)
      .frame(maxWidth: .infinity)
    }
  }
}
