//
//  SystemNotificationConfiguration.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This type can be used to configure the look and behavior of
 a `SystemNotification` view.
 */
public struct SystemNotificationConfiguration {
    
    /// Create a notification configuration.
    ///
    /// - Parameters:
    ///   - animation: The animation to apply when sliding in the notification.
    ///   - backgroundColor: A custom background color to apply to the notification.
    ///   - cornerRadius: A custom corner radius to apply to the notification.
    ///   - duration: The number of seconds the notification should be presented.
    ///   - edge: The edge from which to slide in the notification.
    ///   - isSwipeToDismissEnabled: Whether or not a user can swipe to dismiss a notification.
    ///   - shadowColor: The shadow color to apply to the notification.
    ///   - shadowOffset: The vertical offset of the notification shadow.
    ///   - shadowRadius: The shadow radius to apply to the notification.
    public init(
        animation: Animation = .spring(),
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        duration: TimeInterval = 3,
        edge: SystemNotificationEdge = .top,
        isSwipeToDismissEnabled: Bool = true,
        shadowColor: Color = .black.opacity(0.1),
        shadowOffset: CGFloat = 5,
        shadowRadius: CGFloat = 7.5) {
        self.animation = animation
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.duration = duration
        self.edge = edge
        self.isSwipeToDismissEnabled = true
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
    }
    
    /**
     This is a standard notification configuration.
     */
    public static let standard = SystemNotificationConfiguration()
    
    /**
     The animation to apply when sliding in the notification.
     */
    public var animation: Animation
    
    /**
     A custom background color to apply to the notification.
     */
    public var backgroundColor: Color?
    
    /**
     A custom corner radius to apply to the notification.
     */
    public var cornerRadius: CGFloat?
    
    /**
     The number of seconds the notification should be presented.
     */
    public var edge: SystemNotificationEdge
    
    /**
     Whether or not a user can swipe to dismiss a notification.
     */
    public var isSwipeToDismissEnabled: Bool
    
    /**
     The min width of the notification.
     */
    public var duration: TimeInterval
    
    /**
     The shadow color to apply to the notification.
     */
    public var shadowColor: Color
    
    /**
     The vertical offset of the notification shadow.
     */
    public var shadowOffset: CGFloat
    
    /**
     The shadow radius to apply to the notification.
     */
    public var shadowRadius: CGFloat
}
