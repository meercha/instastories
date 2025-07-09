//
//  StoryBundle.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

public struct StoryBundle: Identifiable, Hashable, Codable {
  public var id: String
  var profileName: String
  var profileImage: String
  var isSeen: Bool = false
  var stories: [Story]
}
