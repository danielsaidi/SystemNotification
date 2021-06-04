//
//  SystemNotificationContext.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This context can be used to present system notifications in
 easier and more flexible ways.
 
 To use this class, create a `@StateObject` instance in your
 presenting view, then bind the context to the view with the
 context-specific `systemNotification` modifier. You can now
 call the context's `present` functions to present different
 notifications with different configurations with the single
 modifier, instead of having separate states and bindings to
 manage each notification.
 */
public class SystemNotificationContext: ObservableObject {
    
    public init() {}
    
    @Published public var configuration = SystemNotificationConfiguration.standard
    @Published public var content = AnyView(EmptyView())
    @Published public var isActive = false
    
    public var isActiveBinding: Binding<Bool> {
        .init(get: { self.isActive },
              set: { self.isActive = $0 }
        )
    }
        
    /**
     Manually dismiss the current notification, if any.
     */
    public func dismiss() {
        isActive = false
    }
    
    /**
     Present a `SystemNotificationMessage` as a notification.
     */
    public func present<Content: View>(
        content: Content,
        configuration: SystemNotificationConfiguration = .standard) {
        self.configuration = configuration
        self.content = AnyView(content)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isActive = true
        }
    }
    
    /**
     Present a `SystemNotificationMessage` as a notification.
     */
    public func present<Content: View>(
        configuration: SystemNotificationConfiguration = .standard,
        @ViewBuilder _ content: @escaping () -> Content) {
        present(content: content(), configuration: configuration)
    }
}
