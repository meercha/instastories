//
//  UserDefaultsStorySeenStore.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

final class UserDefaultsStorySeenStore: StorySeenStore {
  func isStorySeen(bundleId: String) -> Bool {
    seenStories.contains(key(for: bundleId))
  }
  
  func markAsSeen(bundleId: String) async throws {
    var set = seenStories
    set.insert(key(for: bundleId))
    seenStories = set
  }
  
  private let seenStoriesBundleKey = "seen_storiesBundle"

  private var seenStories: Set<String> {
    get {
      let array = UserDefaults.standard.stringArray(forKey: seenStoriesBundleKey) ?? []
      return Set(array)
    }
    set {
      UserDefaults.standard.set(Array(newValue), forKey: seenStoriesBundleKey)
    }
  }

  private func key(for bundleId: String) -> String {
    return "\(bundleId)"
  }
}
