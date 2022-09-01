# Getting Started

This article describes how to get started with SystemNotification.


## What is a system notification?

SystemNotification lets you present any SwiftUI view as a iOS system notifications, which is the notification banner that appears from the top when you e.g. toggle silent mode or connect your AirPods.



## How does it work?

A system notification can be added to a view hierarchy just as you add `sheet`, `alert` and `fullScreenModal` modifiers:

```swift
yourView
    .systemNotification(...)
```

You can use both view- and context-based notifications, use pre-defined or custom views and style your notifications to great extent.



## View-based notifications

View-based notifications work just like `sheet`, `alert` and `fullScreenModal` modifiers.

To use a view-based notification, just provide the `systemNotification` modifier with an `isActive` binding, an optional `configuration` and the view to present:

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
            configuration: .standard    // Defines duration, style etc.
        ) {
            Text("This is a custom notification")
                .padding()
        }
    }
}
```

View-based notifications are easy to use, but if you plan on presenting many different kind of notifications, the context-based approach is more versatile.



## Context-based notifications

Context-based notifications work similar to `sheet`, `alert` and `fullScreenModal`, but instead of providing a view and presentation binding, you use an observable ``SystemNotificationContext`` instead.

To use a context-based notification, create a context instance and use it in the `.systemNotification` modifier, then use the context to present any notification:

```swift
struct MyView: View {

    @StateObject 
    private var notification = SystemNotificationContext()

    var body: some View {
        List {
            Button("Show standard notification", action: showStandardNotification)
            Button("Show orange notification", action: showOrangeNotification)
        }.systemNotification(notification)
    }
    
    func showStandardNotification() {
        notification.present {
            Text("This notification uses a standard configuration")
                .padding()
        }
    }
    
    func showOrangeNotification() {
        notification.present(
            configuration: .init(backgroundColor: .orange)
        ) {
            Text("This notification uses a custom configuration")
                .padding()
        }
    }
}
```

Context-based notifications lets you use the same context in your entire application, with a single notification modifier being applied to the view hierarchy. This ensures that multiple notifications will not be presented at the same time. 

Try to apply the context-based notifier to the root view, e.g. a `TabView` or `NavigationView`. This will ensure that the modifier is presented regardless or where in the app the notification is presented. Note that modal sheets and covers must have the notification modifier applied once more. 

Context-based notifications are very versatile and a great choice if you want to present many different notifications with a single modifier.



## How to mimic the iOS system notification

The standard iOS system notification has a special look, with a leading tinted icon, a title and a message.

To mimic this notification, just use a ``SystemNotificationMessage``, which lets you specify an icon, title and message, as well as an optional, custom configuration.  

You can present this message just like you would any other view, with either a view- or context-based modifier:

```swift
struct MyView: View {

    @State private var isActive = false

    var body: some View {
        List {
            Button("Toggle notification", action: toggleNotification)
        }.systemNotification(isActive: $isActive) {
            SystemNotificationMessage(
                icon: Image(systemName: "bell.slash.fill"),
                title: "Silent Mode",
                text: "On",
                configuration: .init(iconColor: .red)
            )
        }
    }
    
    func toggleNotification() {
        isActive.toggle()
    }
}
```

The message configuration lets you modify the notification's style and behavior.



## Configuration

You have full control over the look and behavior of your notifications. See ``SystemNotificationConfiguration`` and ``SystemNotificationMessageConfiguration`` for more information and have a look at the demo app for examples. 
