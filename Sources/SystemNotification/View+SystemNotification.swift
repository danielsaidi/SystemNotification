//
//  View+SystemNotification.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /// Attach a ``SystemNotification`` to the view.
    ///
    /// State-based notifications use a single binding value
    /// to control a specific notification.
    func systemNotification<Content: View>(
        isActive: Binding<Bool>,
        content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            SystemNotification(
                isActive: isActive,
                content: { _ in content() }
            )
        }
    }
    
    /// Attach a system notification context to the view.
    ///
    /// Context-based notifications can use a single context
    /// to handle many different notifications.
    ///
    /// After applying the modifier, you can use the context
    /// to present a notification.
    func systemNotification(
        _ context: SystemNotificationContext
    ) -> some View {
        self.systemNotification(
                isActive: context.isActiveBinding,
                content: { context.content }
            )
            .environmentObject(context)
    }
}
