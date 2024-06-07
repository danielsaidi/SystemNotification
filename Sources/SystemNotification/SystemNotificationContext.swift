//
//  SystemNotificationContext.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-02.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This context can be used to present system notifications
/// in a more flexible way.
public class SystemNotificationContext: ObservableObject {
    
    public init() {}
    
    public typealias Action = () -> Void
    
    @Published
    public var content = AnyView(EmptyView())
    
    @Published
    public var isActive = false
    
    
    public var isActiveBinding: Binding<Bool> {
        .init(get: { self.isActive },
              set: { self.isActive = $0 }
        )
    }
}

@MainActor
public extension SystemNotificationContext {
    
    /// Dismiss the current notification, if any.
    func dismiss() {
        dismiss {}
    }
        
    /// Dismiss the current notification, if any.
    func dismiss(
        completion: @escaping Action
    ) {
        guard isActive else { return completion() }
        isActive = false
        perform(after: 0.3, action: completion)
    }
    
    /// Present a system notification.
    func present<Content: View>(
        _ content: Content,
        afterDelay delay: TimeInterval = 0
    ) {
        dismiss {
            self.perform(after: delay) {
                self.presentAfterDismiss(content)
            }
        }
    }
    
    /// Present a system notification.
    func present<Content: View>(
        afterDelay delay: TimeInterval = 0,
        @ViewBuilder content: @escaping () -> Content
    ) {
        present(content(), afterDelay: delay)
    }
    
    /// Present a system notification message.
    func presentMessage<IconType: View>(
        _ message: SystemNotificationMessage<IconType>,
        afterDelay delay: TimeInterval = 0
    ) {
        present(message, afterDelay: delay)
    }
}

@MainActor
private extension SystemNotificationContext {
    
    func perform(
        _ action: @escaping Action,
        after seconds: TimeInterval
    ) {
        guard seconds > 0 else { return action() }
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            action()
        }
    }
    
    func perform(after seconds: TimeInterval, action: @escaping Action) {
        perform(action, after: seconds)
    }
    
    func presentAfterDismiss<Content: View>(_ content: Content) {
        self.content = AnyView(content)
        perform(setActive, after: 0.1)
    }
    
    func setActive() {
        isActive = true
    }
}
