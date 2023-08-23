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

Just apply a `systemNotification` modifier to your view and provide an `isActive` binding and a `content` builder:

```swift
struct ContentView: View {

    @State 
    private var isActive = false

    var body: some View {
        NavigationView {
            List {
                Button("Show") { isActive = true }
                Button("Hide") { isActive = false }
                Button("Toggle") { isActive.toggle() }
            }
        }
        .systemNotification(isActive: $isActive) {
            SystemNotificationMessage(
                icon: Image(systemName: "star.fill")
                text: Text("This is a standard notification message with just the small text and a star icon")
            )
        }
    }
}
```

State-based notifications are easy to use, but are less flexible than context-based ones.



## Context-based notifications

Context-based notifications use an observable context instead of state:

```swift
struct ContentView: View {

    @StateObject 
    private var context = SystemNotificationContext()

    var body: some View {
        NavigationView {
            List {
                Button("Show notification", action: showNotification)
                Button("Show orange notification", action: showCustomNotification)
            }
        }
        .environmentObject(context)
        .systemNotification(context)
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
                Text("Custom notification")
                    .font(.headline)
                Divider()
                Text("SystemNotification supports using any content views you like.")
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}
```

In the code above, we both apply a system notification, but also passes in the context as an environment object. This lets other views in the view hierarchy use it to present a notifications from the same root view. 



## Sheets and full screen covers

Since sheets and full screen cover will cover the presenting view, you must apply a new view modifier to their root views. 

You can still use the same context in your modals, but that will make the screen below a sheet present the same notification. 

Make sure to consider that various platforms behave different when picking a proper notification mechanism. For instance, since iPad sheets are presented as center square modals, a system notification may not be the best solution there.  



## Notification views

You can present any custom view as a system notification, for instance:

```swift
struct MyView: View {

    @StateObject 
    private var context = SystemNotificationContext()

    var body: some View {
        List {
            Button("Show notification", action: showNotification)
        }.systemNotification(context)
    }
    
    func showNotification() {
        notification.present {
            Text("Hello, world!")
        }
    }
}
```

To fully mimic the iOS system notification, you can use a ``SystemNotificationMessage``:

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

The `style` parameter lets you style the message.  To style the notification shape, you must provide a ``SystemNotificationStyle`` when setting up or presenting the notification.
