//
//  View+SystemNotification.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /// Attach a ``SystemNotification`` to the view.
    ///
    /// State-based system notifications make it easy to use
    /// a single binding to control a specific notification.
    ///
    /// After applying the modifier, you can use the binding
    /// to present the provided `content`.
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
    /// Context-based system notifications make it very easy
    /// to show multiple notifications with a single context.
    ///
    /// After applying the modifier, you can use the context
    /// to present notifications.
    ///
    /// This modifier will also pass in the context into the
    /// environment, as an environment object.
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
