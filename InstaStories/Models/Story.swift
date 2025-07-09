//
//  Story.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

public struct Story: Identifiable, Hashable, Codable {
  public var id: String
  var imageURL: String
  var isLiked: Bool?
  var band: String?
  var song: String?
}
