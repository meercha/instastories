//
//  ContentView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var storyViewModel: StoryViewModel
  @State var verticalDragAmount = 0.0
  
  var body: some View {
    NavigationView {
      VStack {
        contentView
      }
      .task {
        await storyViewModel.loadStories()
      }
      .navigationTitle("Instagram")
    }
  }

  @ViewBuilder
  private var contentView: some View {
    switch storyViewModel.state {
    case .loading:
      ProgressView()

    case .empty:
      Text("Empty Stance / in progress")

    case .error(let message):
      Text(message)

    case .data(let stories):
      storiesList(stories: stories)
    }
  }

  @ViewBuilder
  private func storiesList(stories: [StoryBundle]) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        MyProfileStoryView()

        ForEach(Array(stories.enumerated()), id: \.offset) { index, storyBundle in
          ProfileView(storyBundleId: storyBundle.id)
            .environmentObject(storyViewModel)
            .onAppear {
                Task {
                    if index == stories.count - 3 {
                        // await item.onAppear()
                      await storyViewModel.loadStories()
                    }
                }
            }
        }
        
        if storyViewModel.isLoadingMore {
            ProgressView().padding(.horizontal)
        }
      }
      .padding()
      .padding(.top, 10)
    }

    Color.clear
      .fullScreenCover(isPresented: $storyViewModel.showStory) {
        StoryView()
          .environmentObject(storyViewModel)
          .offset(y: verticalDragAmount > 0 ? verticalDragAmount : 0)
          .gesture(
            DragGesture()
              .onChanged { drag in
                withAnimation {
                  verticalDragAmount = drag.translation.height
                }
              }
              .onEnded { drag in
                withAnimation {
                  if drag.translation.height > 100 {
                    storyViewModel.showStory = false
                    verticalDragAmount = 0
                  } else {
                    verticalDragAmount = 0
                  }
                }
              }
          )
      }
  }
}
