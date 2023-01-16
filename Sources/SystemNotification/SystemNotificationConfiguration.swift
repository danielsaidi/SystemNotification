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
 a ``SystemNotification`` view.
 */
public struct SystemNotificationConfiguration {

    /**
     Create a system notification configuration.

     - Parameters:
       - animation: The animation to apply when sliding in the notification, by default `.spring()`.
       - backgroundColor: A custom background color to apply to the notification, by default `nil`.
       - cornerRadius: A custom corner radius to apply to the notification, by default `nil`.
       - duration: The number of seconds the notification should be presented, by default `3`.
       - edge: The edge from which to slide in the notification, by default `.top`.
       - isSwipeToDismissEnabled: Whether or not a user can swipe to dismiss a notification, by default `true`.
       - shadowColor: The shadow color to apply to the notification, by default `.black.opacity(0.1)`.
       - shadowOffset: The vertical offset of the notification shadow, by default `5`.
       - shadowRadius: The shadow radius to apply to the notification, by default `7.5`.
     */
    public init(
        animation: Animation = .spring(),
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        duration: TimeInterval = 3,
        edge: SystemNotificationEdge = .top,
        isSwipeToDismissEnabled: Bool = true,
        shadowColor: Color = .black.opacity(0.1),
        shadowOffset: CGFloat = 5,
        shadowRadius: CGFloat = 7.5
    ) {
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

     You can apply a custom value to this property to affect
     all system notification within an app.
     */
    public static var standard = SystemNotificationConfiguration()
    
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
