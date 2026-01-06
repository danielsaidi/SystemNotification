//
//  SystemNotificationMessage.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view mimics the view that is shown within a native iOS system notification.
///
/// You can provide a custom icon, title, and text, and e.g. animate the icon when
/// it's presented.
///
/// You can easily create custom messages, by extending this type with message
/// builders, for instance:
///
/// ```swift
/// extension SystemNotificationMessage where IconView == Image {
///
///     static func silentMode(on: Bool) -> Self {
///         ...
///     }
/// }
/// ```
public struct SystemNotificationMessage<IconView: View>: View {
    
    /// Create a system notification message view.
    ///
    /// - Parameters:
    ///   - icon: The leading icon view.
    ///   - title: The bold title text, by default `nil`.
    ///   - text: The plain message text.
    ///   - style: An optional, explicit style to apply..
    ///   - bundle: The bundle of the localized texts, by default `.main`.
    public init(
        icon: IconView,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        style: SystemNotificationMessageStyle? = nil,
        bundle: Bundle? = nil
    ) {
        self.icon = icon
        self.title = title
        self.text = text
        self.initStyle = style
        self.bundle = bundle
    }

    /// Create a system notification message view.
    ///
    /// - Parameters:
    ///   - icon: The leading icon image.
    ///   - title: The bold title text, by default `nil`.
    ///   - text: The plain message text.
    ///   - style: An optional, explicit style to apply.
    ///   - bundle: The bundle of the localized texts, by default `.main`.
    public init(
        icon: Image,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        style: SystemNotificationMessageStyle? = nil,
        bundle: Bundle? = nil
    ) where IconView == Image {
        self.icon = icon
        self.title = title
        self.text = text
        self.initStyle = style
        self.bundle = bundle
    }

    /// Create a system notification message view.
    ///
    /// - Parameters:
    ///   - title: The bold title text, by default `nil`.
    ///   - text: The plain message text.
    ///   - style: An optional, explicit style to apply.
    ///   - bundle: The bundle of the localized texts, by default `.main`.
    public init(
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        style: SystemNotificationMessageStyle? = nil,
        bundle: Bundle? = nil
    ) where IconView == EmptyView {
        self.icon = EmptyView()
        self.title = title
        self.text = text
        self.initStyle = style
        self.bundle = bundle
    }
    
    let icon: IconView
    let title: LocalizedStringKey?
    let text: LocalizedStringKey
    let initStyle: SystemNotificationMessageStyle?
    let bundle: Bundle?
    
    @Environment(\.systemNotificationMessageStyle)
    private var environmentStyle
    
    public var body: some View {
        HStack(spacing: style.iconTextSpacing) {
            iconView
                .id(UUID())
            textContent
            iconView.opacity(0.001)
        }
        .padding(.vertical, style.padding.height)
        .padding(.horizontal, style.padding.width)
        .background(style.backgroundColor)
    }
}

private extension SystemNotificationMessage {
    
    var style: SystemNotificationMessageStyle {
        initStyle ?? environmentStyle
    }
    
    func foregroundColor(
        for color: Color
    ) -> Color {
        style.foregroundColor ?? color
    }
}

private extension SystemNotificationMessage {

    var textContent: some View {
        VStack(spacing: style.titleTextSpacing) {
            if let title = title {
                Text(title, bundle: bundle ?? nil)
                    .font(style.titleFont)
                    .foregroundStyle(foregroundColor(for: style.titleColor))
            }
            Text(text, bundle: bundle ?? nil)
                .font(style.textFont)
                .foregroundStyle(foregroundColor(for: style.textColor))
        }
        .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    var iconView: some View {
        icon.font(style.iconFont)
            .foregroundStyle(foregroundColor(for: style.iconColor))
    }
}

#Preview {

    VStack {
        Group {
            SystemNotificationMessage(
                icon: Image(systemName: "bell.slash.fill"),
                title: "Silent mode",
                text: "On"
            )
            .systemNotificationMessageStyle(
                .init(
                    backgroundColor: .yellow,
                    iconColor: .red
                )
            )

            SystemNotificationMessage(
                icon: Color.red.frame(width: 20, height: 20),
                text: "Custom icon view, no title"
            )
            .systemNotificationMessageStyle(
                .init(iconColor: .red)
            )

            SystemNotificationMessage(
                title: "No icon",
                text: "On"
            )
            .systemNotificationMessageStyle(
                .init(iconColor: .red)
            )

            SystemNotificationMessage(
                icon: Image(systemName: "exclamationmark.triangle"),
                title: "Warning",
                text: "This is a long warning message to demonstrate multiline messages."
            )
            .systemNotificationMessageStyle(.warning)
        }
        .background(Color.white)
        .cornerRadius(5)
        .padding()
    }
    .background(Color.gray)
}
