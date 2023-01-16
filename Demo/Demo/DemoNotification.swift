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
    
    static var customStyle: SystemNotificationStyle {
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
            icon: .error,
            title: "Error",
            text: "This is an error message that comes in from the bottom.",
            style: .init(
                iconColor: .white,
                textColor: .white,
                titleColor: .white,
                titleFont: .headline
            )
        )
    }
    
    static var errorStyle: SystemNotificationStyle {
        .init(backgroundColor: .red, edge: .bottom)
    }
    
    static var localized: some View {
        SystemNotificationMessage(
            icon: .globe,
            title: "notification.title",
            text: "notification.text")
    }
    
    static var silentModeOff: some View {
        SystemNotificationMessage(
            icon: .silentModeOff,
            title: "Silent mode",
            text: "Off")
    }
    
    static var silentModeOn: some View {
        SystemNotificationMessage(
            icon: .silentModeOn,
            title: "Silent mode",
            text: "On",
            style: .init(iconColor: .red)
        )
    }
    
    static var `static`: some View {
        SystemNotificationMessage(
            icon: .static,
            title: "Non-dismissing notification",
            text: "You can use custom bindings to not auto-dismiss a notification.\nSwipe up to dismiss this one.")
    }
    
    static var warning: some View {
        SystemNotificationMessage(
            icon: .warning,
            title: "Warning",
            text: "This is a long message to demonstrate multiline messages, which should center aligned and support many lines of text.",
            style: .init(
                iconColor: .white,
                iconFont: .headline,
                textColor: .white,
                titleColor: .white,
                titleFont: .headline
            )
        )
    }
    
    static var warningStyle: SystemNotificationStyle {
        .init(backgroundColor: .orange)
    }
}
