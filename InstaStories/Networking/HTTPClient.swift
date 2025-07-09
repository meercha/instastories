//
//  HTTPClient.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import Foundation

public protocol HTTPClientTask {
  func cancel()
}

protocol HTTPClient {
  typealias Result = (Data, HTTPURLResponse)
  
  func get(from url: URL) async throws -> Result
}
