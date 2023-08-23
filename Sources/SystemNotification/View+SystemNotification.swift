//
//  View+SystemNotification.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Attach a ``SystemNotification`` to the view.
     
     View-based system notifications give you control over a
     single notification.
     
     After attaching the modifier, you can use the `isActive`
     binding to present the provided `content`.
     */
    func systemNotification<Content: View>(
        isActive: Binding<Bool>,
        configuration: SystemNotificationConfiguration = .standard,
        style: SystemNotificationStyle = .standard,
        content: @escaping () -> Content
    ) -> some View {
        ZStack(alignment: style.edge.alignment) {
            self
            SystemNotification(
                isActive: isActive,
                configuration: configuration,
                style: style,
                content: { _ in content() }
            )
        }
    }
    
    /**
     Attach a system notification context to the view.
     
     Context-based system notifications make it easy to show
     many different notifications with a single context.
     
     After attaching the modifier, you can use the context's
     present functions to present different notifications.
     */
    func systemNotification(
        _ context: SystemNotificationContext
    ) -> some View {
        self.systemNotification(
            isActive: context.isActiveBinding,
            configuration: context.configuration,
            style: context.style,
            content: { context.content }
        )
    }
}
