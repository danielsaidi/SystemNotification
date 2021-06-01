//
//  SystemNotificationConfiguration.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension SystemNotification {
    
    /**
     This type can be used to configre the look and behavior
     of a `SystemNotification`.
     */
    public struct Configuration {
        
        public init(
            animation: Animation = .spring(),
            backgroundColor: Color? = nil,
            cornerRadius: CGFloat? = nil,
            duration: TimeInterval = 3,
            edge: Edge = .top,
            minWidth: CGFloat = 120,
            shadowRadius: CGFloat = 5) {
            self.animation = animation
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.duration = duration
            self.edge = edge
            self.minWidth = minWidth
            self.shadowRadius = shadowRadius
        }
        
        public let animation: Animation
        public let backgroundColor: Color?
        public let cornerRadius: CGFloat?
        public let edge: Edge
        public let minWidth: CGFloat
        public let duration: TimeInterval
        public let shadowRadius: CGFloat
    }
}
