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
    
    /// Dismiss the current notification, if any.
    public func dismiss() {
        dismiss {}
    }
        
    /// Dismiss the current notification, if any.
    public func dismiss(
        completion: @escaping Action
    ) {
        guard isActive else { return completion() }
        isActive = false
        perform(after: 0.3, action: completion)
    }
    
    /// Present a system notification.
    public func present<Content: View>(
        _ content: Content
    ) {
        dismiss {
            self.presentAfterDismiss(content)
        }
    }
    
    /// Present a system notification.
    public func present<Content: View>(
        @ViewBuilder content: @escaping () -> Content
    ) {
        present(content())
    }
}

private extension SystemNotificationContext {
    
    func perform(_ action: @escaping Action, after seconds: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: action)
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
