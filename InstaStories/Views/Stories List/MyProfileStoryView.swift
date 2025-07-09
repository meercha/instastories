//
//  MyProfileStoryView.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

struct MyProfileStoryView: View {
  @Environment(\.colorScheme) var scheme
  
  // For this case only we will use a local image 
  let imageUrl: String = "myProfile"
  
  var body: some View {
    VStack(spacing: 15) {
      Button {
        print("do nothing")
      } label: {
        Image(imageUrl)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 80, height: 80)
          .clipShape(Circle())
          .overlay(alignment: .bottomTrailing, content: {
            Image(systemName: "plus")
              .font(.system(size: 12, weight: .bold))
              .padding(4)
              .background(scheme == .dark ? .white : .black, in: Circle())
              .foregroundStyle(scheme == .dark ? .black : .white)
              .padding(4)
              .background(scheme == .dark ? .black : .white, in: Circle())
          })
      }
      
      Text("Your Story")
          .font(.caption)
          .truncationMode(.tail)
    }
    .padding(4)
  }
}

#Preview {
  MyProfileStoryView()
}
