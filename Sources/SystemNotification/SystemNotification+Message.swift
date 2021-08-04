//
//  SystemNotification+Message.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension SystemNotification where Content == SystemNotificationMessage {
    
    /// Create a system notification that presents a standard `SystemNotificationMessage`.
    ///
    /// - Parameters:
    ///   - icon: The left-size icon.
    ///   - title: The bold title text.
    ///   - text: The plain message text.
    ///   - isActive: A binding that controls the active state of the notification.
    ///   - configuration: The notification configuration to use.
    init(
        icon: Image = Image(""),
        title: LocalizedStringKey,
        text: LocalizedStringKey,
        isActive: Binding<Bool>,
        configuration: SystemNotificationConfiguration = .standard) {
        self.init(
            isActive: isActive,
            configuration: configuration) { _ in
            SystemNotificationMessage(icon: icon, title: title, text: text)
        }
    }
}
