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
     Attach a specific system notification to the view.
     
     This will setup the notification in a view hierarchy in
     which it will be properly presented.
     */
    func systemNotification<Content: View>(
        @ViewBuilder _ notification: @escaping () -> SystemNotification<Content>) -> some View {
        let notif = notification()
        return ZStack(alignment: notif.configuration.edge.alignment) {
            self
            notif
        }
    }
    
    /**
     Attach a system notification context to the view.
     
     This context can then be used to present many different
     notifications using the same context. That way, there's
     no need to have a specific state and modifier for every
     notification you want to present.
     */
    func systemNotification(context: SystemNotificationContext) -> some View {
        ZStack(alignment: context.configuration.edge.alignment) {
            self
            SystemNotification(
                isActive: context.isActiveBinding,
                configuration: context.configuration,
                content: { _ in context.content })
        }
    }
}
