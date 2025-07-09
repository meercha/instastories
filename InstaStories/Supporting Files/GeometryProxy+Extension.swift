//
//  GeometryProxy+Extension.swift
//  InstaStories
//
//  Created by Mircea Ghenciu on 09.07.2025.
//

import SwiftUI

extension GeometryProxy {
  func getAngle() -> Angle {
    // converting offset into 45 degree rotation
    let progress = self.frame(in: .global).minX / self.size.width
    let rotationAngle: CGFloat = 45
    let degrees = rotationAngle * CGFloat(progress)
    
    return Angle(degrees: Double(degrees))
  }
}

