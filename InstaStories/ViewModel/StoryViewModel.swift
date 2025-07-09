//
//  StoryViewModel.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

@MainActor
class StoryViewModel: ObservableObject {
  @Published var stories : [StoryBundle] = []
  @Published var showStory: Bool = false
  @Published var currentStory: String = ""
  @Published var isLoadingMore: Bool = false
  
  var state: State = .loading

  private var currentOffset: Int = 0
  private let pageSize: Int
  private var hasMore = true
  
  private let storiesLoader: StoriesLoader
  private let storyLikeStore: StoryLikeStore
  private let storySeenStore: StorySeenStore
  
  enum State: Equatable {
      case data([StoryBundle])
      case empty
      case error(String)
      case loading
  }
  
  init(storiesLoader: StoriesLoader, storyLikeStore: StoryLikeStore, storySeenStore: StorySeenStore) {
    self.storiesLoader = storiesLoader
    self.storyLikeStore = storyLikeStore
    self.storySeenStore = storySeenStore
    self.pageSize = storiesLoader.pageSize
  }
  
  func loadStories() async {
    guard hasMore else { return }
    
    state = .loading
    
    do {
      let newStories = try await storiesLoader.loadStories(limit: pageSize,
                                                           offset: currentOffset)
      if newStories.isEmpty {
        hasMore = false
        state = stories.isEmpty ? .empty : .data(stories)
        return
      }
      
      currentOffset += newStories.count
      stories += newStories
      state = .data(stories)
    } catch {
      state = .error(error.localizedDescription)
    }
  }
  
  func bundle(for id: String) -> StoryBundle? {
    stories.first(where: { $0.id == id })
  }
  
  func toggleLike(bundleId: String, storyId: String) async {
    if isLiked(bundleId: bundleId, storyId: storyId) {
      await unlike(bundleId: bundleId, storyId: storyId)
    } else {
      await like(bundleId: bundleId, storyId: storyId)
    }
  }
  
  private func like(bundleId: String, storyId: String) async {
    try? await storyLikeStore.likeStory(bundleId: bundleId, storyId: storyId)
  }
  
  private func unlike(bundleId: String, storyId: String) async {
    try? await storyLikeStore.unlikeStory(bundleId: bundleId, storyId: storyId)
  }
  
  func isLiked(bundleId: String, storyId: String) -> Bool {
    storyLikeStore.isStoryLiked(bundleId: bundleId, storyId: storyId)
  }
  
  func markBundleAsSeen(_ id: String) async {
    try? await storySeenStore.markAsSeen(bundleId: id)
  }
  
  func isBundleSeen(_ id: String) -> Bool {
    storySeenStore.isStorySeen(bundleId: id)
  }
  
  @MainActor
  func updateStory(forward: Bool = true, timerProgress: Double, for storyBundle: StoryBundle) {
    guard let bundleIndex = stories.firstIndex(where: { $0.id == storyBundle.id }) else { return }
    
    if !forward {
      moveToPreviousBundle(from: bundleIndex)
      return
    }
    
    let index = min(Int(timerProgress), storyBundle.stories.count - 1)
    let story = storyBundle.stories[index]
    
    guard let lastStory = storyBundle.stories.last else { return }
    
    if story.id == lastStory.id {
      Task { await markBundleAsSeen(storyBundle.id) }
      moveToNextBundle(from: bundleIndex)
    }
  }
  
  private func moveToPreviousBundle(from index: Int) {
    guard index > 0 else { return }
    let previousBundle = stories[index - 1]
    withAnimation { currentStory = previousBundle.id }
  }
  
  private func moveToNextBundle(from index: Int) {
    if index == stories.count - 1 {
      withAnimation { showStory = false }
    } else {
      let nextBundle = stories[index + 1]
      withAnimation { currentStory = nextBundle.id }
    }
  }
}
