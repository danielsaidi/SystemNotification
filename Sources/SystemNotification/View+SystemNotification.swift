//
//  View+SystemNotification.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Attach a system notification view to the view.
     
     View-based system notifications give you control over a
     single system notification. If you want to present many
     different notifications, consider using a context-based
     view modifier instead.
     */
    func systemNotification<Content: View>(
        isActive: Binding<Bool>,
        configuration: SystemNotificationConfiguration = .standard,
        content: @escaping () -> Content) -> some View {
        ZStack(alignment: configuration.edge.alignment) {
            self
            SystemNotification(
                isActive: isActive,
                configuration: configuration,
                content: { _ in content() })
        }
    }
    
    /**
     Attach a system notification context to the view.
     
     Context-based system notifications make it easy to show
     many different notifications with a single context. You
     then use this context to control which views to present,
     which configuration to use etc.
     */
    func systemNotification(
        _ context: SystemNotificationContext) -> some View {
        self.systemNotification(
            isActive: context.isActiveBinding,
            configuration: context.configuration,
            content: { context.content })
    }
}

public extension View {
    
    @available(*, deprecated, renamed: "systemNotification")
    func systemNotification(
        context: SystemNotificationContext) -> some View {
        self.systemNotification(context)
    }
}
