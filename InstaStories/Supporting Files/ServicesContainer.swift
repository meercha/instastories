//
//  ServicesContainer.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

struct ServicesContainer {
  let storiesLoader: StoriesLoader
  let storyLikeStore: StoryLikeStore
  let storySeenStore: StorySeenStore
}

struct AppEnvironment {
  let services: ServicesContainer
}
