//
//  SystemNotificationMessage.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the content of the native iOS notification
 that is presented when e.g. silent mode is toggled.
 
 When you create a standard message, you can provide it with
 an optional icon, as well as a title and text. You can also
 provide a custom ``SystemNotificationMessageConfiguration``
 that defines the style of the message.
 */
public struct SystemNotificationMessage: View {
    
    /**
     Create a standard system notification message.
     
     - Parameters:
      - icon: The optional, left icon, by default `nil`.
      - title: The bold title text, by default `nil`.
      - text: The plain message text.
      - style: The style to use, by default `.standard`.
     */
    public init(
        icon: Image? = nil,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        style: SystemNotificationMessageStyle = .standard
    ) {
        self.icon = icon
        self.title = title
        self.text = text
        self.style = style
    }
    
    /**
     Create a standard system notification message.
     
     - Parameters:
       - icon: The optional, left icon, by default `nil`.
       - title: The bold title text, by default `nil`.
       - text: The plain message text.
       - style: The style to use, by default `.standard`.
     */
    public init(
        icon: Image? = nil,
        title: String? = nil,
        text: String,
        style: SystemNotificationMessageStyle = .standard
    ) {
        self.icon = icon
        if let title = title {
            self.title = LocalizedStringKey(title)
        } else {
            self.title = nil
        }
        self.text = LocalizedStringKey(text)
        self.style = style
    }
    
    private let icon: Image?
    private let title: LocalizedStringKey?
    private let text: LocalizedStringKey
    private let style: SystemNotificationMessageStyle
    
    public var body: some View {
        HStack(spacing: style.iconTextSpacing) {
            iconView
            textContent
            iconView.opacity(0.01)
        }
        .padding(.vertical, style.padding.height)
        .padding(.horizontal, style.padding.width)
    }
}

private extension SystemNotificationMessage {
    
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
        if let icon = icon {
            icon.font(style.iconFont)
                .foregroundColor(style.iconColor)
        } else {
            EmptyView()
        }
    }
}

struct SystemNotificationMessage_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack(spacing: 20) {
            SystemNotificationMessage(
                icon: Image(systemName: "bell.slash"),
                title: "Silent mode",
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
    }
}
