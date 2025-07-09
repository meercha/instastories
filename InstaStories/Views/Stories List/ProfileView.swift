//
//  ProfileView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
  var storyBundleId: String
  
  @Environment(\.colorScheme) var scheme
  @EnvironmentObject var storyViewModel: StoryViewModel
  
  @State private var isLoading = true
  
  var body: some View {
    if let storyBundle = storyViewModel.bundle(for: storyBundleId),
       let url = URL(string: storyBundle.profileImage) {
      
      VStack {
        ZStack {
          KFImage(url)
            .resizable()
            .onSuccess { _ in
              isLoading = false
            }
            .onFailure { _ in
              isLoading = false
            }
            .onAppear {
              isLoading = true
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 80, height: 80)
            .clipShape(Circle())
          
          if isLoading {
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle())
              .frame(width: 40, height: 40)
          }
        }
        .padding(2)
        .background(scheme == .dark ? .black : .white, in: Circle())
        .padding(3)
        .overlay {
          StoryStatusView(seen: storyViewModel.isBundleSeen(storyBundle.id))
        }
        .onTapGesture {
          withAnimation {
            storyViewModel.currentStory = storyBundle.id
            storyViewModel.showStory = true
          }
        }
        
        Text(storyBundle.profileName)
          .font(.caption)
          .truncationMode(.tail)
      }
      .padding(4)
    }
  }
}
