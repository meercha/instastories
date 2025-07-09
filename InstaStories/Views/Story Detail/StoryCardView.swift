//
//  StoryCardView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

struct StoryCardView: View {
  @EnvironmentObject var storyViewModel: StoryViewModel
  @Binding var storyBundle: StoryBundle
  @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  @State var timerProgress: CGFloat = 0
  @State private var isPaused = false
  
  var body: some View {
    
    Group {
      let index = min(Int(timerProgress), storyBundle.stories.count - 1)
      let story = storyBundle.stories[index]
      let isLiked = storyViewModel.isLiked(bundleId: storyBundle.id, storyId: story.id)
      
      GeometryReader { proxy in
        VStack(spacing: 14) {
          MediaView(imageName: story.imageURL)
            .overlay(content: {
              NavigationOverlayView(progress: $timerProgress, count: storyBundle.stories.count) { forward in
                storyViewModel.updateStory(forward: forward, timerProgress: timerProgress, for: storyBundle)
              }
            })
            .onLongPressGesture(minimumDuration: 0.1, perform: {
              isPaused = true
            }, onPressingChanged: { changed in
              if isPaused {
                isPaused.toggle()
              }
            })
          
          storyActionsView(storyId: story.id, isLiked: isLiked)
        }
        .background(Color.black)
        .overlay(alignment: .top) {
          VStack(spacing: 6) {
            CapsuleProgressOverlayView(progress: $timerProgress, range: self.storyBundle.stories.indices)
            
            StoryDetailsView(storyBundle: storyBundle, story: story) {
              storyViewModel.showStory = false
            }
          }
          .padding([.top, .bottom])
          .opacity(isPaused ? 0 : 1)
          .animation(.easeInOut(duration: 0.2), value: isPaused)
        }
        .rotation3DEffect(
          proxy.getAngle(),
          axis: (x: 0, y: 1, z: 0),
          anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing,
          perspective: 2.5)
      }
    }
    .onAppear(perform: {
      timerProgress = 0
    })
    .onReceive(timer) { _ in
      updateTimer()
    }
  }
  
  @ViewBuilder private func storyActionsView(storyId: String, isLiked: Bool) -> some View {
    HStack(spacing: 12) {
      MesssageInputButtonView(action: {})
      
      HeartButtonView(
        action: {
          Task {
            await storyViewModel.toggleLike(bundleId: self.storyBundle.id, storyId: storyId)
          }
        },
        liked: isLiked
      )
      .tint(isLiked ? .red : .white)
      .frame(height: 20)
      
      
      MessagesButtonView(action: {})
        .tint(.white)
        .frame(height: 20)
    }
    .padding(.horizontal, 20)
    .opacity(isPaused ? 0 : 1)
    .animation(.easeInOut(duration: 0.2), value: isPaused)
  }
  
  func updateTimer() {
    guard !isPaused else { return }
    
    if storyViewModel.currentStory == storyBundle.id {
      if timerProgress < CGFloat(storyBundle.stories.count) {
        withAnimation {
          timerProgress += 0.025
        }
      } else {
        storyViewModel.updateStory(timerProgress: timerProgress, for: storyBundle)
      }
    }
  }
}
