//
//  StoryLikeStore.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

protocol StoryLikeStore {
  func likeStory(bundleId: String, storyId: String) async throws
  func unlikeStory(bundleId: String, storyId: String) async throws
  func isStoryLiked(bundleId: String, storyId: String) -> Bool
}
