//
//  SystemNotificationMessage.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the content of the native iOS notification
 that is presented when e.g. silent mode is toggled.
 
 You can provide this message with an optional icon, a title
 and a text. You can also provide this message with a custom
 ``SystemNotificationMessageStyle`` to define its style.
 */
public struct SystemNotificationMessage<IconView: View>: View {
    
    /**
     Create a standard system notification message that uses
     a custom view as its icon.

     - Parameters:
       - icon: The leading icon view.
       - title: The bold title text, by default `nil`.
       - text: The plain message text.
       - style: The style to use, by default `.standard`.
     */
    public init(
        icon: IconView,
        title: String? = nil,
        text: String,
        style: SystemNotificationMessageStyle = .standard
    ) {
        self.icon = icon
        self.title = Self.title(for: title)
        self.text = LocalizedStringKey(text)
        self.style = style
    }

    /**
     Create a standard system notification message that uses
     an image as its icon.

     - Parameters:
       - icon: The leading icon image.
       - title: The bold title text, by default `nil`.
       - text: The plain message text.
       - style: The style to use, by default `.standard`.
     */
    public init(
        icon: Image,
        title: String? = nil,
        text: String,
        style: SystemNotificationMessageStyle = .standard
    ) where IconView == Image {
        self.icon = icon
        self.title = Self.title(for: title)
        self.text = LocalizedStringKey(text)
        self.style = style
    }

    /**
     Create a standard system notification message.

     - Parameters:
       - title: The bold title text, by default `nil`.
       - text: The plain message text.
       - style: The style to use, by default `.standard`.
     */
    public init(
        title: String? = nil,
        text: String,
        style: SystemNotificationMessageStyle = .standard
    ) where IconView == EmptyView {
        self.icon = EmptyView()
        self.title = Self.title(for: title)
        self.text = LocalizedStringKey(text)
        self.style = style
    }
    
    let icon: IconView
    let title: LocalizedStringKey?
    let text: LocalizedStringKey
    let style: SystemNotificationMessageStyle
    
    public var body: some View {
        HStack(spacing: style.iconTextSpacing) {
            iconView
            textContent
            iconView.opacity(0.001)
        }
        .padding(.vertical, style.padding.height)
        .padding(.horizontal, style.padding.width)
    }
}

private extension SystemNotificationMessage {

    static func title(for title: String?) -> LocalizedStringKey? {
        if let title = title {
            return LocalizedStringKey(title)
        } else {
            return nil
        }
    }
    
    var textContent: some View {
        VStack(spacing: style.titleTextSpacing) {
            if let title = title {
                Text(title)
                    .font(style.titleFont)
                    .foregroundColor(style.titleColor)
            }
            Text(text)
                .font(style.textFont)
                .foregroundColor(style.textColor)
        }
        .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    var iconView: some View {
        icon.font(style.iconFont)
            .foregroundColor(style.iconColor)
    }
}

struct SystemNotificationMessage_Previews: PreviewProvider {

    struct Preview: View {

        var body: some View {
            VStack {
                Group {
                    SystemNotificationMessage(
                        icon: Image(systemName: "bell.slash.fill"),
                        title: "Silent mode",
                        text: "On",
                        style: .init(iconColor: .red)
                    )

                    SystemNotificationMessage(
                        icon: Color.red.frame(width: 20, height: 20),
                        text: "Custom icon view, no title",
                        style: .init(iconColor: .red)
                    )

                    SystemNotificationMessage(
                        title: "No icon",
                        text: "On",
                        style: .init(iconColor: .red)
                    )

                    SystemNotificationMessage(
                        icon: Image(systemName: "exclamationmark.triangle"),
                        title: "Warning",
                        text: "This is a long message to demonstrate multiline messages.",
                        style: .init(
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

            }.background(Color.gray)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
