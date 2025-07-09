//
//  StorySeenStore.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

protocol StorySeenStore {
  func isStorySeen(bundleId: String) -> Bool
  func markAsSeen(bundleId: String) async throws
}
