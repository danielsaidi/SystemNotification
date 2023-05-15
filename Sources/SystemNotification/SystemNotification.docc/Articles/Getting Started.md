# Getting Started

This article describes how to get started with the SystemNotification library.

SystemNotification is a `SwiftUI` library that lets you mimic the native iOS system notification, which for instance is presented when you toggle silent mode on and off, connect your AirPods etc. 

These notifications have a standard style that aims to mimic the iOS system notification look and feel, but can be customized to fit your specific needs.



## How does it work?

You must first add SystemNotification to your project, preferably using the Swift Package Manager:

```
https://github.com/danielsaidi/SystemNotification.git
```

You can then add a system notification to a view hierarchy just as you add `sheet`, `alert` and `fullScreenModal`:

```swift
import SystemNotification

struct MyView: View {

    var body: some View {
        Text("Hello, world")
            .systemNotification(...)
    }
}
```

You can use both state- and context and message-based notifications and style your notifications to great extent.



## State-based notifications

State-based notifications work just like state-based `sheet`, `alert` and `fullScreenModal` modifiers.

For state-based notifications, just provide the `systemNotification` modifier with an `isActive` binding and the view to present:

```swift
struct MyView: View {

    @State 
    private var isActive = false

    var body: some View {
        List {
            Button("Show") { isActive = true }
            Button("Hide") { isActive = false }
            Button("Toggle") { isActive.toggle() }
        }.systemNotification(
            isActive: $isActive,
            content: notification
        )
    }

    func notification() -> some View {
        SystemNotificationMessage(
            icon: Image(systemName: "star.fill")
            text: Text("This is a standard notification message with just the small text and a star icon")
        )
    }
}
```

State-based notifications are easy to use, but the context-based approach is better if you want to present many different notifications with a single modifier.



## Context-based notifications

Context-based notifications work similar to `sheet`, `alert` and `fullScreenModal`, but use an observable context instead of state:

```swift
struct MyView: View {

    @StateObject 
    var notification = SystemNotificationContext()

    var body: some View {
        List {
            Button("Show notification", action: showNotification)
            Button("Show orange notification", action: showCustomNotification)
        }.systemNotification(notification)
    }
    
    func showNotification() {
        notification.present {
            SystemNotificationMessage(
                icon: Image(systemName: "􀋚"),
                title: Text("Silent mode")
                text: Text("Off"),
                style: .init(iconColor: .red)
            )
        }
    }
    
    func showCustomNotification() {
        notification.present(
            configuration: .init(backgroundColor: .orange)
        ) {
            VStack {
                Text("Custom notification").font(.headline)
                Divider()
                Text("SystemNotification supports using any views you like as notification messages.")
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}
```

This lets you use the same ``SystemNotificationContext`` in your entire application. You can then pass down the context into the view hierarchy and use it to present a notification from anywhere in your app. 

You can for instance apply a context-based `.systemNotification` modifier to a root `TabView` or `NavigationView`, which ensures that the notification is presented regardless or where in the app the presentation is triggered.



## Sheets and full screen covers

Since sheets and full screen cover will cover the presenting view, you must apply a new view modifier to their root views. You can still use the same context everywhere, but will for sheets notice that the underlying screen will also present the notification. 

Make sure to consider that various platforms behave different when picking a proper notification mechanism. For instance, since iPad sheets are presented as center square modals, a system notification may not be the best solution there.  



## Notification views

You can present any custom view as a system notification, for instance:

```swift
struct MyView: View {

    @StateObject 
    private var notification = SystemNotificationContext()

    var body: some View {
        List {
            Button("Show notification", action: showNotification)
        }.systemNotification(notification)
    }
    
    func showNotification() {
        notification.present {
            Text("Hello, world!")
        }
    }
}
```

However, to mimic the iOS system notification, you can use a ``SystemNotificationMessage`` instead:

```swift
struct MyView: View {

    @StateObject 
    private var notification = SystemNotificationContext()

    var body: some View {
        List {
            Button("Show notification", action: showNotification)
        }.systemNotification(notification)
    }
    
    func showNotification() {
        notification.present {
            SystemNotificationMessage(
                icon: Image(systemName: "bell.slash.fill"),
                title: "Silent Mode",
                text: "On",
                style: .init(iconColor: .red)
            )
        }
    }
}
```

The `style` parameter lets you modify the message style, like the colors, spacings etc. of the message view.  To style the surrounding notification shape, you must provide a ``SystemNotificationStyle`` when setting up or presenting the notification.
