//
//  SystemNotificationConfiguration.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This configuration can be used to configure the behavior of
 a ``SystemNotification``.
 
 You can easily create new configurations like this:
 
 ```swift
 extension SystemNotificationConfiguration {
 
    static var custom = Self(animation: .easeInOut)
 }
 ```

 The ``standard`` configuration will be used by default when
 you don't provide a custom configuration.
 */
public struct SystemNotificationConfiguration {

    /**
     Create a system notification configuration.

     - Parameters:
       - animation: The animation to apply when sliding in the notification, by default `.spring()`.
       - duration: The number of seconds the notification should be presented, by default `3`.
       - isSwipeToDismissEnabled: Whether or not a user can swipe to dismiss a notification, by default `true`.
     */
    public init(
        animation: Animation = .spring(),
        duration: TimeInterval = 3,
        isSwipeToDismissEnabled: Bool = true
    ) {
        self.animation = animation
        self.duration = duration
        self.isSwipeToDismissEnabled = isSwipeToDismissEnabled
    }

    /// The animation to use when presenting a notification.
    public var animation: Animation

    /// The number of seconds a notification should be shown.
    public var duration: TimeInterval

    /// Whether or not swiping can to dismiss a notification.
    public var isSwipeToDismissEnabled: Bool

    @available(*, deprecated, message: "This is just used to bridge between the configuration and the new style. This will be removed in the next minor update.")
    var style: SystemNotificationStyle = .standard
}

public extension SystemNotificationConfiguration {
    
    /**
     The standard system notification configuration.

     You can change this value to affect the global default.
     */
    static var standard = Self()
}
