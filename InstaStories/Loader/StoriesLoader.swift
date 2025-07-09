//
//  StoriesLoader.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

public typealias LoadStoriesResult = Result<[StoryBundle], Error>

protocol StoriesLoader {
  var pageSize: Int { get set }
  
  func loadStories(limit: Int, offset: Int) async throws -> [StoryBundle]
}
