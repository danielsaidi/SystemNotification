//
//  SystemNotificationStyle.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This type can be used to style ``SystemNotification`` views.
 */
public struct SystemNotificationStyle {

    /**
     Create a system notification configuration.

     - Parameters:
       - backgroundColor: A custom background color to apply to the notification, by default `nil`.
       - cornerRadius: A custom corner radius to apply to the notification, by default `nil`.
       - padding: A custom edge padding to apply to the notification, by default `nil`.
       - edge: The edge from which to slide in the notification, by default `.top`.
       - shadowColor: The shadow color to apply to the notification, by default `.black.opacity(0.1)`.
       - shadowOffset: The vertical offset of the notification shadow, by default `5`.
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

    /**
     This is a standard notification configuration.

     You can apply a custom value to this property to affect
     all system notification within an app.
     */
    public static var standard = SystemNotificationStyle()

    /**
     The standard background color to apply to notifications.
     */
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

    /**
     The standard padding to apply to system notifications.
     */
    public static var standardPadding: EdgeInsets {
        #if os(iOS)
        EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        #else
        EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        #endif
    }

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
     A custom edge padding to apply to the notification.
     */
    public var padding: EdgeInsets

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
