//
//  SystemNotificationPresenter.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/**
 This convenience protocol can be used to let multiple types
 present notifications in the same way.

 For instance, you could add app-specific extensions to this
 protocol to let it present app-specific notifications:

 ```swift
 extension SystemNotificationPresenter {

     func presentAppSpecificNotification() {
         presentSystemNotification {
             SystemNotificationMessage(
                 icon: .alert,
                 title: "Alert!",
                 text: "Houston, we have a problem!"
             )
         }
     }
 }
 ```

 This protocol will apply a slight delay to the presentation,
 and make sure to launch it on the main dispatch queue.

 Note that using this protocol is completely optional, and a
 matter of taste. You could also create app-specific message
 values as well.
 */
public protocol SystemNotificationPresenter {

    /// The system notification to use when presenting.
    var systemNotification: SystemNotificationContext { get }
}

public extension SystemNotificationPresenter {

    /// Present a certain system notification.
    func presentSystemNotification<Content: View>(
        after delay: TimeInterval = 0.5,
        content: @escaping () -> Content
    ) {
        perform(after: delay) {
            systemNotification.present(content)
        }
    }
}

private extension SystemNotificationPresenter {

    func perform(
        after delay: TimeInterval,
        action: @escaping () -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            action()
        }
    }
}
