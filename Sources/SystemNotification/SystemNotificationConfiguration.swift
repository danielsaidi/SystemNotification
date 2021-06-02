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
        
        /// Create a notification configuration.
        ///
        /// - Parameters:
        ///   - animation: The animation to apply when sliding in the notification.
        ///   - backgroundColor: A custom background color to apply to the notification.
        ///   - cornerRadius: A custom corner radius to apply to the notification.
        ///   - duration: The number of seconds the notification should be presented.
        ///   - edge: The edge from which to slide in the notification.
        ///   - minWidth: The min width of the notification.
        ///   - shadowRadius: The shadow radius to apply to the notification.
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
        
        /**
         The animation to apply when sliding in the notification.
         */
        public let animation: Animation
        
        /**
         A custom background color to apply to the notification.
         */
        public let backgroundColor: Color?
        
        /**
         A custom corner radius to apply to the notification.
         */
        public let cornerRadius: CGFloat?
        
        /**
         The number of seconds the notification should be presented.
         */
        public let edge: Edge
        
        /**
         The edge from which to slide in the notification.
         */
        public let minWidth: CGFloat
        
        /**
         The min width of the notification.
         */
        public let duration: TimeInterval
        
        /**
         The shadow radius to apply to the notification.
         */
        public let shadowRadius: CGFloat
    }
    
}
