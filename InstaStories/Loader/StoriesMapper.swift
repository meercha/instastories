//
//  StoriesMapper.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

internal final class StoriesMapper {
  internal static func decode(_ data: Data, from response: HTTPURLResponse) throws -> [StoryBundle] {
    guard let storyBundle = try? JSONDecoder().decode([StoryBundle].self, from: data) else {
      throw NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])
    }
  
    return storyBundle
  }
}
