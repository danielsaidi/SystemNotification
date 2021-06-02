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
public class SystemNotificationContext {
    
    public init() {}
    
    @Published public var isActive = false
    
    @Published public internal(set) var content: (() -> AnyView)? {
        didSet { isActive = content != nil }
    }
    
    public var isActiveBinding: Binding<Bool> {
        .init(get: { self.isActive },
              set: { self.isActive = $0 }
        )
    }
        
    public func dismiss() {
        isActive = false
    }
    
    public func present<Content: View>(_ notification: @autoclosure @escaping () -> SystemNotification<Content>) {
        self.content = { AnyView(notification()) }
    }
}
