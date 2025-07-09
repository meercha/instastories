//
//  UserDefaultsStoryLikingStore.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

final class UserDefaultsStoryLikingStore: StoryLikeStore {
  private let likedStoriesKey = "liked_stories"

  private var likedStories: Set<String> {
    get {
      let array = UserDefaults.standard.stringArray(forKey: likedStoriesKey) ?? []
      return Set(array)
    }
    set {
      UserDefaults.standard.set(Array(newValue), forKey: likedStoriesKey)
    }
  }

  private func key(for bundleId: String, storyId: String) -> String {
    return "\(bundleId)_\(storyId)"
  }

  func likeStory(bundleId: String, storyId: String) async throws {
    var set = likedStories
    set.insert(key(for: bundleId, storyId: storyId))
    likedStories = set
  }

  func unlikeStory(bundleId: String, storyId: String) async throws {
    var set = likedStories
    set.remove(key(for: bundleId, storyId: storyId))
    likedStories = set
  }

  func isStoryLiked(bundleId: String, storyId: String) -> Bool {
    likedStories.contains(key(for: bundleId, storyId: storyId))
  }
}
