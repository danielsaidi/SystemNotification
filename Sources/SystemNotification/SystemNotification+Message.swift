//
//  SystemNotification+Message.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension SystemNotification where Content == SystemNotificationMessage {
    
    /**
     Create a system notification instance that will use the
     `SystemNotificationMessage` view when presented.
     
     - Parameters:
      - icon: The left-size icon, if any.
      - title: The bold title text, if any.
      - text: The plain message text.
      - isActive: A binding that controls the active state of the notification.
      - configuration: The notification configuration to use.
     */
    init(
        icon: Image? = nil,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        isActive: Binding<Bool>,
        configuration: SystemNotificationConfiguration = .standard) {
        self.init(
            message: SystemNotificationMessage(icon: icon, title: title, text: text),
            isActive: isActive,
            configuration: configuration)
    }
    
    /**
     Create a system notification instance that will use the
     `SystemNotificationMessage` view when presented.
     
     - Parameters:
      - icon: The left-size icon, if any.
      - title: The bold title text, if any.
      - text: The plain message text.
      - isActive: A binding that controls the active state of the notification.
      - configuration: The notification configuration to use.
     */
    init(
        icon: Image? = nil,
        title: String? = nil,
        text: String,
        isActive: Binding<Bool>,
        configuration: SystemNotificationConfiguration = .standard) {
        self.init(
            message: SystemNotificationMessage(icon: icon, title: title, text: text),
            isActive: isActive,
            configuration: configuration)
    }
    
    /**
     Create a system notification instance that will use the
     `SystemNotificationMessage` view when presented.
     
     - Parameters:
      - message: The message to display.
      - isActive: A binding that controls the active state of the notification.
      - configuration: The notification configuration to use.
     */
    init(
        message: SystemNotificationMessage,
        isActive: Binding<Bool>,
        configuration: SystemNotificationConfiguration = .standard) {
        self.init(
            isActive: isActive,
            configuration: configuration) { _ in
            message
        }
    }
}
