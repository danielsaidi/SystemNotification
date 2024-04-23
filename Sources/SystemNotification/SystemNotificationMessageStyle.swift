//
//  SystemNotificationMessageStyle.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can style a ``SystemNotificationMessage``.
///
/// Apply ``SwiftUI/View/systemNotificationMessageStyle(_:)``
/// if an app or notification should use a custom style.
///
/// You can easily create a custom style like this:
///
/// ```swift
/// extension SystemNotificationMessageStyle {
///    static var custom = Self(iconColor: .yellow)
/// }
/// ```
///
/// The ``standard`` value is used by default when you don't
/// apply a custom value.
public struct SystemNotificationMessageStyle {

    /// Create a custom system notification message style.
    ///
    /// - Parameters:
    ///   - iconColor: The color to apply to the icon.
    ///   - iconFont: The font to apply to the icon.
    ///   - iconTextSpacing: The spacing to apply between the icon and the text.
    ///   - padding: The padding to add to the content.
    ///   - textColor: The color to apply to the text.
    ///   - textFont: The font to apply to the text.
    ///   - titleColor: The color to apply to the title.
    ///   - titleFont: The font to apply to the title.
    ///   - titleTextSpacing: The spacing to apply between the title and the text.
    public init(
        iconColor: Color = .primary.opacity(0.6),
        iconFont: Font = Font.title3,
        iconTextSpacing: CGFloat = 20,
        padding: CGSize = .init(width: 15, height: 7),
        textColor: Color = .primary.opacity(0.4),
        textFont: Font = Font.footnote.bold(),
        titleColor: Color = .primary.opacity(0.6),
        titleFont: Font = Font.footnote.bold(),
        titleTextSpacing: CGFloat = 2
    ) {
        self.iconColor = iconColor
        self.iconFont = iconFont
        self.iconTextSpacing = iconTextSpacing
        self.padding = padding
        self.textColor = textColor
        self.textFont = textFont
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.titleTextSpacing = titleTextSpacing
    }
    
    /// The color to apply to the icon.
    public var iconColor: Color
    
    /// The font to apply to the icon.
    public var iconFont: Font
    
    /// The spacing to apply between the icon and the text.
    public var iconTextSpacing: CGFloat
    
    /// The padding to add to the content.
    public var padding: CGSize
    
    /// The color to apply to the text.
    public var textColor: Color
    
    /// The font to apply to the text.
    public var textFont: Font
    
    /// The color to apply to the title.
    public var titleColor: Color
    
    /// The font to apply to the title.
    public var titleFont: Font
    
    /// The spacing to apply between the title and the text.
    public var titleTextSpacing: CGFloat
}

public extension SystemNotificationMessageStyle {

    /// The standard system notification message style.
    ///
    /// You can set this style to change the global default.
    static var standard = Self()
}

public extension View {

    /// Apply a ``SystemNotificationMessageStyle`` to the view.
    func systemNotificationMessageStyle(
        _ style: SystemNotificationMessageStyle
    ) -> some View {
        self.environment(\.systemNotificationMessageStyle, style)
    }
}

private extension SystemNotificationMessageStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: SystemNotificationMessageStyle = .standard
    }
}

public extension EnvironmentValues {

    var systemNotificationMessageStyle: SystemNotificationMessageStyle {
        get { self [SystemNotificationMessageStyle.Key.self] }
        set { self [SystemNotificationMessageStyle.Key.self] = newValue }
    }
}
