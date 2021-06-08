//
//  DemoNotification.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-06-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SystemNotification

struct DemoNotification {
    
    private init() {}
    
    static var custom: some View {
        VStack(spacing: 0) {
            customVerticalSegment
            customVerticalSegment
            Color.yellow
            customVerticalSegment
            customVerticalSegment
        }.frame(height: 150)
    }
    
    static var customConfig: SystemNotificationConfiguration {
        .init(backgroundColor: .blue)
    }
    
    static var customVerticalSegment: some View {
        HStack {
            Color.clear
            Color.clear
            Color.yellow
            Color.clear
            Color.clear
            Color.clear
            Color.clear
            Color.clear
            Color.clear
            Color.clear
        }
    }
    
    static var error: some View {
        SystemNotificationMessage(
            icon: Image(systemName: "exclamationmark.triangle"),
            title: "Error",
            text: "This is an error message that comes in from the bottom.",
            configuration: .init(
                iconColor: .white,
                textColor: .white,
                titleColor: .white,
                titleFont: .headline
            )
        )
    }
    
    static var errorConfig: SystemNotificationConfiguration {
        .init(backgroundColor: .red, edge: .bottom)
    }
    
    static var localized: some View {
        SystemNotificationMessage(
            icon: Image(systemName: "globe"),
            title: "title",
            text: "text")
    }
    
    static var silentModeOff: some View {
        SystemNotificationMessage(
            icon: Image(systemName: "bell.fill"),
            title: "Silent mode",
            text: "Off")
    }
    
    static var silentModeOn: some View {
        SystemNotificationMessage(
            icon: Image(systemName: "bell.slash.fill"),
            title: "Silent mode",
            text: "On",
            configuration: .init(iconColor: .red)
        )
    }
    
    static var warning: some View {
        SystemNotificationMessage(
            icon: Image(systemName: "exclamationmark.triangle"),
            title: "Warning",
            text: "This is a long message to demonstrate multiline messages, which should center aligned and support many lines of text.",
            configuration: .init(
                iconColor: .white,
                iconFont: .headline,
                textColor: .white,
                titleColor: .white,
                titleFont: .headline
            )
        )
    }
    
    static var warningConfig: SystemNotificationConfiguration {
        .init(backgroundColor: .orange)
    }
}
