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

To use a state-based notification, just provide the `systemNotification` modifier with an `isActive` binding and the view to present:

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

State-based notifications are easy to use, but the context-based approach is better if you want to present many different notifications with a single binding.



## Context-based notifications

Context-based notifications work similar to `sheet`, `alert` and `fullScreenModal`, but use an observable ``SystemNotificationContext`` instead of state:

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

This approach lets you use the same context in your entire application and a single view modifier being applied to a single view hierarchy. 

You can then use pass down the context into the view hierarchy and use it to present a notification from anywhere in your app. 

You can for instance apply a context-based `.systemNotification` modifier to a root `TabView` or `NavigationView`, which ensures that the notification is presented regardless or where in the app the presentation is triggered.

Context-based notifications are very versatile and a great choice if you want to present many different notifications with a single modifier.



## Sheets and full screen covers

Since any new sheets and full screen cover will cover the presenting view, you must apply a new view modifier to the modal root view. 

You can however still use the same context to present your notifications. The only effect that will have is that you'll see the underlying message sliding in if you are using a sheet. 

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

The `style` parameter lets you modify the message style, like the colors, spacings etc. of the message view.



## How to style a system notification

The ``SystemNotification`` view can be styled in a couple of ways. 

For instance, you can provide a `style` in the view modifier:

```swift
struct MyView: View {

    @StateObject 
    private var notification = SystemNotificationContext()

    var body: some View {
        List {
            ...
        }.systemNotification(
            notification,
            style: .init(backgroundColor: .red)
        )
    }
}
```

This will be used as the default style, and applied to all notifications. 

You can however override this style whenever you present a notification with a context:

```
notification.present(
    style: .init(backgroundColor: .green)
) {
    Text("A green message")
        .foregroundColor(.white)
}
```

This style is applied for as long as the notification is presented, then resets to the default one.



## How to configure a system notification

Just like with the style, a ``SystemNotification`` can be configured in a couple of ways. 

For instance, you can provide a `configuration` in the view modifier:

```swift
struct MyView: View {

    @StateObject 
    private var notification = SystemNotificationContext()

    var body: some View {
        List {
            ...
        }.systemNotification(
            notification,
            configuration: .init(duration: 5)
        )
    }
}
```

This will be used as the default configuration, and applied to all notifications. 

You can however override this configuration whenever you present a notification with a context:

```
notification.present(
    configuration: .init(duration: 10)
) {
    Text("An important, long-lived notification")
}
```

This configuration is applied for as long as the notification is presented, then resets to the default one.

