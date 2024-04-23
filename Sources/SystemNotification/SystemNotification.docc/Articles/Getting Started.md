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

After adding SystemNotification to your project, you can add a system notification to a view just as you add a sheet, alert or full screen modal, using ``SwiftUI/View/systemNotification(_:)`` or ``SwiftUI/View/systemNotification(isActive:configuration:style:content:)``:

```swift
import SystemNotification

struct MyView: View {

    var body: some View {
        Text("Hello, world")
            .systemNotification(...)
    }
}
```

You can use both state and ``SystemNotificationContext``-based notifications and style your custom notifications to great extent.



## State-based notifications

State-based notifications work like state-based `sheet`, `alert` and `fullScreenModal` modifiers, and take an `isActive` binding:

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

State-based notifications are easy to use, but less flexible than context-based ones, since they are meant to present a specific view.



## Context-based notifications

Context-based notifications use an observable ``SystemNotificationContext`` instead of state:

```swift
struct ContentView: View {

    @StateObject 
    private var notification = SystemNotificationContext()

    var body: some View {
        NavigationView {
            List {
                Button("Show notification", action: showNotification)
                Button("Show orange notification", action: showCustomNotification)
            }
        }
        .environmentObject(notification)
        .systemNotification(notification)
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

In the code above, we apply a notification context to the view, and also pass it as an environment object to let other views use it as well. 



## Notification views

You can present any custom view as a system notification, for instance plain text:

```swift
struct MyView: View {

    @StateObject 
    private var notification = SystemNotificationContext()

    var body: some View {
        List {
            Button("Show notification", action: showNotification)
        }
        .systemNotification(notification)
    }
    
    func showNotification() {
        notification.present {
            Text("Hello, world!")
        }
    }
}
```

You can use a ``SystemNotificationMessage`` to easily mimic a iOS system notification:

```swift
struct MyView: View {

    @StateObject 
    private var notification = SystemNotificationContext()

    var body: some View {
        List {
            Button("Show notification", action: showNotification)
        }
        .systemNotification(notification)
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



## Further Reading

@Links(visualStyle: detailedGrid) {
    
    - <doc:Configuration>
    - <doc:Styling>
}
