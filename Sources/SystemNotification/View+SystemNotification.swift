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
     Attach a system notification to the view. This adds the
     view to a `ZStack` and places it below the notification,
     using an alignment to fit the notification edge.
     */
    func systemNotification<Content: View>(
        @ViewBuilder _ notification: @escaping () -> SystemNotification<Content>) -> some View {
        let notif = notification()
        return ZStack(alignment: notif.configuration.edge.alignment) {
            self
            notif
        }
    }
}
