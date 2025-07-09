//
//  InstaStoriesApp.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

@main
struct InstaStoriesApp: App {
  
  private let appEnvironment: AppEnvironment = {
    guard let url = URL(string: Api.Stories.endpoint) else {
      fatalError("Invalid URL for Stories endpoint: \(Api.Stories.endpoint)")
    }
    
    let services = ServicesContainer(
      storiesLoader: RemoteStoriesLoader(
        url: url,
        client: URLSessionHTTPClient()
      ),
      storyLikeStore: UserDefaultsStoryLikingStore(),
      storySeenStore: UserDefaultsStorySeenStore()
    )
    
    return AppEnvironment(services: services)
  }()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(StoryViewModel(
          storiesLoader: appEnvironment.services.storiesLoader,
          storyLikeStore: appEnvironment.services.storyLikeStore,
          storySeenStore: appEnvironment.services.storySeenStore
        ))
    }
  }
}
