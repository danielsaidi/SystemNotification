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
      - configuration: The configuration to use, by default `.standard`.
     */
    public init(
        icon: Image? = nil,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        configuration: SystemNotificationMessageConfiguration = .standard
    ) {
        self.icon = icon
        self.title = title
        self.text = text
        self.configuration = configuration
    }
    
    /**
     Create a standard system notification message.
     
     - Parameters:
       - icon: The optional, left icon, by default `nil`.
       - title: The bold title text, by default `nil`.
       - text: The plain message text.
       - configuration: The configuration to use, by default `.standard`.
     */
    public init(
        icon: Image? = nil,
        title: String? = nil,
        text: String,
        configuration: SystemNotificationMessageConfiguration = .standard
    ) {
        self.icon = icon
        if let title = title {
            self.title = LocalizedStringKey(title)
        } else {
            self.title = nil
        }
        self.text = LocalizedStringKey(text)
        self.configuration = configuration
    }
    
    public let configuration: SystemNotificationMessageConfiguration
    
    private let icon: Image?
    private let title: LocalizedStringKey?
    private let text: LocalizedStringKey
    
    public var body: some View {
        HStack(spacing: configuration.iconTextSpacing) {
            iconView
            textContent
            iconView.opacity(0.01)
        }
        .padding(.vertical, configuration.padding.height)
        .padding(.horizontal, configuration.padding.width)
    }
}

private extension SystemNotificationMessage {
    
    var textContent: some View {
        VStack(spacing: configuration.titleTextSpacing) {
            if let title = title {
                Text(title)
                    .font(configuration.titleFont)
                    .foregroundColor(configuration.titleColor)
            }
            Text(text)
                .font(configuration.textFont)
                .foregroundColor(configuration.textColor)
        }
        .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    var iconView: some View {
        if let icon = icon {
            icon.font(configuration.iconFont)
                .foregroundColor(configuration.iconColor)
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
                configuration: SystemNotificationMessageConfiguration(
                    iconColor: .red
                )
            )
            SystemNotificationMessage(
                icon: Image(systemName: "exclamationmark.triangle"),
                title: "Warning",
                text: "This is a long message to demonstrate multiline messages.",
                configuration: SystemNotificationMessageConfiguration(
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
