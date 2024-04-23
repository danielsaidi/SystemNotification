//
//  SystemNotificationMessage.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view mimics the message view that is shown within a
/// native iOS system notification.
///
/// You can provide a custom icon view, title, and text, and
/// e.g. animate the icon when it's presented.
public struct SystemNotificationMessage<IconView: View>: View {
    
    /// Create a system notification message view.
    ///
    /// - Parameters:
    ///   - icon: The leading icon view.
    ///   - title: The bold title text, by default `nil`.
    ///   - text: The plain message text.
    public init(
        icon: IconView,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey
    ) {
        self.icon = icon
        self.title = title
        self.text = text
        self.initStyle = nil
    }

    /// Create a system notification message view.
    ///
    /// - Parameters:
    ///   - icon: The leading icon image.
    ///   - title: The bold title text, by default `nil`.
    ///   - text: The plain message text.
    public init(
        icon: Image,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey
    ) where IconView == Image {
        self.icon = icon
        self.title = title
        self.text = text
        self.initStyle = nil
    }

    /// Create a system notification message view.
    ///
    /// - Parameters:
    ///   - title: The bold title text, by default `nil`.
    ///   - text: The plain message text.
    public init(
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey
    ) where IconView == EmptyView {
        self.icon = EmptyView()
        self.title = title
        self.text = text
        self.initStyle = nil
    }
    
    let icon: IconView
    let title: LocalizedStringKey?
    let text: LocalizedStringKey
    let initStyle: SystemNotificationMessageStyle?
    
    @Environment(\.systemNotificationMessageStyle)
    private var envStyle
    
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
        initStyle ?? envStyle
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
                Text(title)
                    .font(style.titleFont)
                    .foregroundStyle(foregroundColor(for: style.titleColor))
            }
            Text(text)
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
                text: "This is a long message to demonstrate multiline messages."
            )
            .systemNotificationMessageStyle(
                .init(
                    iconColor: .orange,
                    iconFont: .headline,
                    textColor: .orange,
                    titleColor: .orange,
                    titleFont: .headline
                )
            )
        }
        .background(Color.white)
        .cornerRadius(5)
        .padding()
    }
    .background(Color.gray)
}
