//
//  URLSessionHTTPClient.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
  private let session: URLSession
  
  init(session: URLSession = URLSession(configuration: .ephemeral)) {
    self.session = session
  }
  
  func get(from url: URL) async throws -> HTTPClient.Result {
    let (data, response) = try await session.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }
    
    return (data, httpResponse)
  }
}
