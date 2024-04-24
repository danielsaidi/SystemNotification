# Getting Started

This article describes how to get started with SystemNotification.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}



## Overview

After adding SystemNotification to your project, you can add a system notification to any view just as you add a `sheet`, `alert` and `fullScreenModal`, with a simple view modifier.

To add a system notification to a view, just use the ``SwiftUI/View/systemNotification(_:)`` view modifier with a state binding or a ``SystemNotificationContext`` instance.

> Important: Since system notifications should be as global as possible, make sure to apply the view modifier to the application root view, e.g. the main `NavigationStack` or ``TabView``. Any new sheets or modals must also have the modifier applied. 

State-based notifications take a boolean state binding and a view builder:

```swift
import SystemNotification

struct MyView: View {

    @State
    var isActive = false

    var body: some View {
        VStack {
            Button("Show notification") {
                isActive = true
            }
        }
        .systemNotification(isActive: $isActive) {
            Text("You can use any custom content view")
                .padding()
        }
    }
}
```

Context-based notifications take a ``SystemNotificationContext`` and can then show different notifications with a single modifier:

```swift
import SystemNotification

struct MyView: View {

    @StateObject
    var notification = SystemNotificationContext()

    var body: some View {
        VStack {
            Button("Show text") {
                notification.present {
                    Text("Context-based notifications are more flexible.")
                        .padding()
                        .multilineTextAlignment(.center)
                }
            }
            Button("Show message") {
                notification.present {
                    SystemNotificationMessage(
                        icon: Text("👍"),
                        title: "Great job!",
                        text: "You presented a native-looking message!"
                    )
                }
            }
        }
        .systemNotification(notification)
    }
}
```

The ``SystemNotificationMessage`` view lets you easily mimic a native notification view, with an icon, an optional title and a text, but you can use any custom view as the notification content view.

You can use the ``SwiftUI/View/systemNotificationConfiguration(_:)`` and ``SwiftUI/View/systemNotificationStyle(_:)`` view modifiers to apply custom configurations and styles.



## How to create custom notification messages

The ``SystemNotificationMessage`` view lets you easily mimic a native notification message, with an icon, an optional title and a text, as well as an explicit style that overrides any environment style.

You can easily extend ``SystemNotificationMessage`` with your own custom messages, which can then be easily presented with the context's ``SystemNotificationContext/presentMessage(_:afterDelay:)`` function:

```swift
extension SystemNotificationMessage where IconView == Image {

    static var itemCreated: Self {
        .init(
            icon: Image(systemName: "checkmark"),
            title: "Item created!",
            text: "A new item was created",
            style: ....
        )
    }
}
```

You can also use the ``SwiftUI/View/systemNotificationMessageStyle(_:)`` view modifier to provide a standard style for all other messages.
