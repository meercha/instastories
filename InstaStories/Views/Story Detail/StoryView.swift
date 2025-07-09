//
//  StoryView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

struct StoryView: View {
  @EnvironmentObject var storyData: StoryViewModel
  
  var body: some View {
    TabView(selection: $storyData.currentStory) {
      ForEach($storyData.stories) { $storyBundle in
        StoryCardView(storyBundle: $storyBundle)
          .environmentObject(storyData)
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.black)
  }
}
