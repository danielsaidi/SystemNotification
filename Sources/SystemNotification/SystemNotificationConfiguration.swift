//
//  SystemNotificationConfiguration.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to configure a ``SystemNotification``.
///
/// See <doc:Getting-Started> for information on how to style and configure
/// a system notification.
///
/// Use ``SwiftUICore/View/systemNotificationConfiguration(_:)``
/// to apply a custom system notification configuration.
///
/// The ``standard`` value is used by default if you don't apply a custom value.
/// You can use ``standardToast`` to present notifications as a bottom toast.
public struct SystemNotificationConfiguration {

    /// Create a custom system notification configuration.
    ///
    /// - Parameters:
    ///   - animation: The animation to apply when sliding in the notification, by default `.bouncy`.
    ///   - duration: The number of seconds the notification should be presented, by default `3`.
    ///   - edge: The edge from which to present the notification, by default `.top`.
    ///   - isSwipeToDismissEnabled: Whether or not a user can swipe to dismiss a notification, by default `true`.
    public init(
        animation: Animation = .bouncy,
        duration: TimeInterval = 3,
        edge: SystemNotificationEdge = .top,
        isSwipeToDismissEnabled: Bool = true
    ) {
        self.animation = animation
        self.duration = duration
        self.edge = edge
        self.isSwipeToDismissEnabled = isSwipeToDismissEnabled
    }

    /// The animation to use when presenting a notification.
    public var animation: Animation

    /// The number of seconds a notification should be shown.
    public var duration: TimeInterval
    
    /// The edge to present from.
    public var edge: SystemNotificationEdge = .top

    /// Whether or not swiping can to dismiss a notification.
    public var isSwipeToDismissEnabled: Bool
}

public extension SystemNotificationConfiguration {
    
    /// The standard system notification configuration.
    static var standard: Self { .init() }
    
    /// A standard toast configuration.
    static var standardToast: Self {
        .init(
            animation: .bouncy,
            edge: .bottom
        )
    }
}

public extension View {

    /// Apply a ``SystemNotificationConfiguration`` to the view.
    func systemNotificationConfiguration(
        _ configuration: SystemNotificationConfiguration
    ) -> some View {
        self.environment(\.systemNotificationConfiguration, configuration)
    }
}

extension View {

    @ViewBuilder
    func systemNotificationConfiguration(
        _ configuration: SystemNotificationConfiguration?
    ) -> some View {
        if let configuration {
            self.environment(\.systemNotificationConfiguration, configuration)
        } else {
            self
        }
    }
}

private extension SystemNotificationConfiguration {

    struct Key: EnvironmentKey {

        static var defaultValue: SystemNotificationConfiguration { .init() }
    }
}

public extension EnvironmentValues {

    var systemNotificationConfiguration: SystemNotificationConfiguration {
        get { self [SystemNotificationConfiguration.Key.self] }
        set { self [SystemNotificationConfiguration.Key.self] = newValue }
    }
}
