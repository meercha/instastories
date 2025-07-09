//
//  RemoteStoriesLoader.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

class RemoteStoriesLoader: StoriesLoader {
  var pageSize: Int
  
  private let url: URL
  private let client: HTTPClient
  
  init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
    self.pageSize = 5
  }
  
  public typealias Result = LoadStoriesResult
  
  func loadStories(limit: Int, offset: Int) async throws -> [StoryBundle] {
    let (data, response) = try await client.get(from: url)
    
    guard (200...299).contains(response.statusCode) else {
      throw URLError(.badServerResponse)
    }
    
    let allStories = try StoriesMapper.decode(data, from: response)
    
    let paginatedStories = Array(allStories.dropFirst(offset).prefix(limit))
    return paginatedStories
  }
}
