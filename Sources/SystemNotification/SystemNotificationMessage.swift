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
 an optional image as well as a title and text. You can also
 provide a custom `configuration`, to customize the style of
 the message.
 */
public struct SystemNotificationMessage: View {
    
    /// Create a standard system notification message.
    ///
    /// - Parameters:
    ///   - icon: The optional, left icon.
    ///   - title: The bold title text.
    ///   - text: The plain message text.
    ///   - configuration: The message configuration to use.
    public init(
        icon: Image?,
        title: String,
        text: String,
        configuration: Configuration = Configuration()) {
        self.icon = icon
        self.title = title
        self.text = text
        self.configuration = configuration
    }
    
    public let configuration: Configuration
    
    private let icon: Image?
    private let title: String
    private let text: String
    
    public var body: some View {
        HStack(spacing: 20) {
            iconView
            textContent
            iconView.opacity(0.01)
        }
        .padding(.vertical, configuration.padding.width)
        .padding(.horizontal, configuration.padding.height)
    }
}

private extension SystemNotificationMessage {
    
    var textContent: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(configuration.titleFont)
                .foregroundColor(configuration.titleColor)
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
                configuration: SystemNotificationMessage.Configuration(
                    iconColor: .red
                )
            )
            SystemNotificationMessage(
                icon: Image(systemName: "exclamationmark.triangle"),
                title: "Warning",
                text: "This is a long message to demonstrate multiline messages.",
                configuration: SystemNotificationMessage.Configuration(
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
