//
//  SystemNotificationStyle.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be used with ``SystemNotification``s.
 
 You can easily create new styles like this:
 
 ```swift
 extension SystemNotificationStyle {
 
    static var custom = Self(backgroundColor: .red)
 }
 ```

 The ``standard`` style will be used by default if you don't
 provide a custom style.
 */
public struct SystemNotificationStyle {

    /**
     Create a system notification style.

     - Parameters:
       - backgroundColor: The background color to apply to the notification, by default `nil`.
       - cornerRadius: The corner radius to apply to the notification, by default `nil`.
       - padding: The edge padding to apply to the notification, by default `nil`.
       - edge: The edge from which to present the notification, by default `.top`.
       - shadowColor: The shadow color to apply to the notification, by default `.black.opacity(0.1)`.
       - shadowOffset: The shadow offset to apply to the notification, by default `5`.
       - shadowRadius: The shadow radius to apply to the notification, by default `7.5`.
     */
    public init(
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        padding: EdgeInsets? = nil,
        edge: SystemNotificationEdge = .top,
        shadowColor: Color = .black.opacity(0.1),
        shadowOffset: CGFloat = 5,
        shadowRadius: CGFloat = 7.5
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.padding = padding ?? Self.standardPadding
        self.edge = edge
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
    }

    /// The standard background color.
    @ViewBuilder
    public static func standardBackgroundColor(for colorScheme: ColorScheme) -> some View {
        if colorScheme == .light {
            Color.primary.colorInvert()
        } else {
            #if os(iOS)
            Color(UIColor.secondarySystemBackground)
            #elseif os(macOS)
            Color.primary.colorInvert()
            #elseif os(macOS)
            Color.secondary
                .colorInvert()
                .background(Color.white)
            #endif
        }
    }

    /// The standard content padding.
    public static var standardPadding: EdgeInsets {
        #if os(iOS)
        EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        #else
        EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        #endif
    }

    /// The background color to apply to the notification.
    public var backgroundColor: Color?

    /// The corner radius to apply to the notification.
    public var cornerRadius: CGFloat?

    /// The edge from which to present the notification.
    public var edge: SystemNotificationEdge

    /// The edge padding to apply to the notification.
    public var padding: EdgeInsets

    /// The shadow color to apply to the notification.
    public var shadowColor: Color

    /// The shadow offset to apply to the notification.
    public var shadowOffset: CGFloat

    /// The shadow radius to apply to the notification.
    public var shadowRadius: CGFloat
}

public extension SystemNotificationStyle {

    /// The standard system notification style.
    ///
    /// You can set this style to change the global default.
    static var standard = Self()
}

public extension View {

    /// Apply a ``SystemNotificationStyle`` to the view.
    func systemNotificationStyle(
        _ style: SystemNotificationStyle
    ) -> some View {
        self.environment(\.autocompleteToolbarStyle, style)
    }
}

private extension SystemNotificationStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: SystemNotificationStyle = .standard
    }
}

public extension EnvironmentValues {

    var autocompleteToolbarStyle: SystemNotificationStyle {
        get { self [SystemNotificationStyle.Key.self] }
        set { self [SystemNotificationStyle.Key.self] = newValue }
    }
}
