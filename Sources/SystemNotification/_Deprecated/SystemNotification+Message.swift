//
//  SystemNotification+Message.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension SystemNotification where Content == SystemNotificationMessage {
    
    @available(*, deprecated, message: "Use SystemNotificationMessage instead.")
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
    
    @available(*, deprecated, message: "Use SystemNotificationMessage instead.")
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
    
    @available(*, deprecated, message: "Use SystemNotificationMessage instead.")
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
