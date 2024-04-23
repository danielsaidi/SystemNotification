//
//  SystemNotificationConfiguration.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to configure ``SystemNotification``.
///
/// Apply ``SwiftUI/View/systemNotificationConfiguration(_:)``
/// if an app should use a custom configuration.
///
/// You can easily create a custom configuration like this:
///
/// ```swift
/// extension SystemNotificationConfiguration {
///     static var custom = Self(animation: .easeInOut)
/// }
/// ```
///
/// The ``standard`` value is used by default when you don't
/// apply a custom value.
public struct SystemNotificationConfiguration {

    /// Create a custom system notification configuration.
    ///
    /// - Parameters:
    ///   - animation: The animation to apply when sliding in the notification, by default `.bouncy`.
    ///   - duration: The number of seconds the notification should be presented, by default `3`.
    ///   - isSwipeToDismissEnabled: Whether or not a user can swipe to dismiss a notification, by default `true`.
    public init(
        animation: Animation = .easeOut,
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
    
    /// The standard system notification configuration.
    ///
    /// You can set this style to change the global default.
    static var standard = Self()
}

public extension View {

    /// Apply a ``SystemNotificationConfiguration`` to the view.
    func systemNotificationConfiguration(
        _ configuration: SystemNotificationConfiguration
    ) -> some View {
        self.environment(\.systemNotificationConfiguration, configuration)
    }
}

private extension SystemNotificationConfiguration {

    struct Key: EnvironmentKey {

        static var defaultValue: SystemNotificationConfiguration = .standard
    }
}

public extension EnvironmentValues {

    var systemNotificationConfiguration: SystemNotificationConfiguration {
        get { self [SystemNotificationConfiguration.Key.self] }
        set { self [SystemNotificationConfiguration.Key.self] = newValue }
    }
}
