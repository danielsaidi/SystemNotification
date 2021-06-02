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
        ///   - animation: The animation to apply when sliding in the notification, by default `.spring`.
        ///   - backgroundColor: A custom background color to apply to the notification, by default `nil`.
        ///   - cornerRadius: A custom corner radius to apply to the notification, by default `nil`.
        ///   - duration: The number of seconds the notification should be presented, by default `3`.
        ///   - edge: The edge from which to slide in the notification, by default `.top`.
        ///   - minWidth: The min width of the notification, by default `120`.
        ///   - shadowRadius: The shadow radius to apply to the notification, by default `5`.
        ///   - useFrostEffectWhereApplicable: Whether or not to apply a frost effect to the notification, if applicable.
        public init(
            animation: Animation = .spring(),
            backgroundColor: Color? = nil,
            cornerRadius: CGFloat? = nil,
            duration: TimeInterval = 3,
            edge: Edge = .top,
            minWidth: CGFloat = 120,
            shadowRadius: CGFloat = 5,
            useFrostEffectWhereApplicable: Bool = true) {
            self.animation = animation
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.duration = duration
            self.edge = edge
            self.minWidth = minWidth
            self.shadowRadius = shadowRadius
            self.useFrostEffectWhereApplicable = useFrostEffectWhereApplicable
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
        
        /**
         Whether or not to apply a frost effect to the notification, if applicable.
         */
        public let useFrostEffectWhereApplicable: Bool
    }
    
}
