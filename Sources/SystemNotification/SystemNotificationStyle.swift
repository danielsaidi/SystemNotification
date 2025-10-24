//
//  SystemNotificationStyle.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style a ``SystemNotification``.
///
/// See <doc:Getting-Started> for information on how to style and configure
/// a system notification.
///
/// Use ``SwiftUICore/View/systemNotificationStyle(_:)`` to use
/// a custom system notification style.
///
/// The ``standard`` style is used by default if you don't apply a custom value.
public struct SystemNotificationStyle {

    /// Create a custom system notification style.
    ///
    /// - Parameters:
    ///   - backgroundColor: The background color to apply, by default `nil`.
    ///   - backgroundMaterial: The background material to apply, by default `.thin`.
    ///   - cornerRadius: The corner radius to apply, by default `nil`.
    ///   - padding: The edge padding to apply, by default `nil`.
    ///   - edge: The edge from which to present the notification, by default `.top`.
    ///   - shadowColor: The shadow color to apply, by default `.black.opacity(0.1)`.
    ///   - shadowOffset: The shadow offset to apply, by default `5`.
    ///   - shadowRadius: The shadow radius to apply, by default `7.5`.
    public init(
        backgroundColor: Color? = nil,
        backgroundMaterial: Material = .thin,
        cornerRadius: CGFloat? = nil,
        padding: EdgeInsets? = nil,
        shadowColor: Color = .black.opacity(0.1),
        shadowOffset: CGFloat = 5,
        shadowRadius: CGFloat = 7.5
    ) {
        self.backgroundColor = backgroundColor
        self.backgroundMaterial = backgroundMaterial
        self.cornerRadius = cornerRadius
        self.padding = padding ?? Self.standardPadding
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

    /// The background color to apply.
    public var backgroundColor: Color?
    
    /// The background material to apply.
    public var backgroundMaterial: Material

    /// The corner radius to apply.
    public var cornerRadius: CGFloat?

    /// The edge padding to apply.
    public var padding: EdgeInsets

    /// The shadow color to apply.
    public var shadowColor: Color

    /// The shadow offset to apply.
    public var shadowOffset: CGFloat

    /// The shadow radius to apply.
    public var shadowRadius: CGFloat
}

public extension SystemNotificationStyle {

    /// The standard system notification style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a ``SystemNotificationStyle`` to the view.
    func systemNotificationStyle(
        _ style: SystemNotificationStyle
    ) -> some View {
        self.environment(\.systemNotificationStyle, style)
    }
}

extension View {

    @ViewBuilder
    func systemNotificationStyle(
        _ style: SystemNotificationStyle?
    ) -> some View {
        if let style {
            self.environment(\.systemNotificationStyle, style)
        } else {
            self
        }
    }
}

private extension SystemNotificationStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: SystemNotificationStyle { .standard }
    }
}

public extension EnvironmentValues {

    var systemNotificationStyle: SystemNotificationStyle {
        get { self [SystemNotificationStyle.Key.self] }
        set { self [SystemNotificationStyle.Key.self] = newValue }
    }
}
