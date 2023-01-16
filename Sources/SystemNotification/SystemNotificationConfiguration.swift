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
     The number of seconds the notification should be presented.
     */
    public var duration: TimeInterval

    /**
     Whether or not a user can swipe to dismiss a notification.
     */
    public var isSwipeToDismissEnabled: Bool

    @available(*, deprecated, message: "This is just used to bridge between the configuration and the new style. This will be removed in the next minor update.")
    var style: SystemNotificationStyle = .standard
}
