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
 various ways.
 
 To use this class, create a `@StateObject` instance in your
 presenting view, then bind the context to the view with the
 context-specific modifier. You can now use `present` on the
 context to present notifications:
 
 ```swift
 @StateObject var context = SystemNotificationContext()
 
 view.systemNotification(context: context)
 
 // To present a notification:
 context.present(myNotification)
 
 // ...or a custom view
 context.present(myCustomView)
 ```
 */
public class SystemNotificationContext: ObservableObject {
    
    public init() {
        content = { SystemNotification(isActive: .constant(false)) { _ in
            AnyView(EmptyView())
        }}
    }
    
    @Published public var isActive = false
    
    @Published public internal(set) var content: (() -> SystemNotification<AnyView>) {
        didSet { isActive = true }
    }
    
    public var isActiveBinding: Binding<Bool> {
        .init(get: { self.isActive },
              set: { self.isActive = $0 }
        )
    }
        
    public func dismiss() {
        isActive = false
    }
    
    /**
     Present a view as content within a `SystemNotification`
     */
    public func present<Content: View>(
        configuration: SystemNotificationConfiguration = .standard,
        @ViewBuilder _ content: @escaping () -> Content) {
        withAnimation {
            self.content = {
                SystemNotification(
                    isActive: self.isActiveBinding,
                    configuration: configuration,
                    content: { _ in AnyView(content()) })
            }
            self.isActive = true
        }
    }
}
