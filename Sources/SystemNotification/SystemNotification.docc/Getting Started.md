# Getting Started

This article describes how to get started with SystemNotification.



## Installation

SystemNotification can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/SystemNotification.git
``` 

or with CocoaPods:

```
pod SystemNotification
```


## How does it work?

SystemNotification lets you present any SwiftUI view as iOS system notifications, which are the ones that appear from the top when you e.g. toggle Silent Mode or connect your AirPods.

System notifications are added just as you add a `sheet`, `alert` and `fullScreenModal`:

```swift
yourView
    .systemNotification(...)
```

You can either present view- or context-based system notifications, use custom views and style the notifications to great extent.



## View-based notifications

View-based notifications work just like `sheet`, `alert` and `fullScreenModal`.

To use a view-based notification, just provide an `isActive` binding, an optional `configuration` and the view to present:

```swift
struct MyView: View {

    @State private var isActive = false

    var body: some View {
        List {
            Button("Toggle notification", action: toggleNotification)
        }.systemNotification(isActive: $isActive) {
            Text("This is a custom notification")
                .padding()
        }
    }
    
    func toggleNotification() {
        isActive.toggle()
    }
}
```

To apply the view-based notification to a view, use the `isActive`-based `systemNotification` view modifier:

```swift
yourView.systemNotification(
    isActive: $isActive,
    configuration: .standard) {
        Text("Here's a notification") // You can use any view
}
```

View-based notifications are easy to use, but if you plan on presenting many different kind of notifications, the context-based approach is more versatile.



## Context-based notifications

Context-based notifications work similar to `sheet`, `alert` and `fullScreenModal`.

To use a context-based notification, create a ``SystemNotificationContext`` instance, provide it in the `.systemNotification` modifier, then use the context to present any notification:

```swift
struct MyView: View {

    @StateObject private var notification = SystemNotificationContext()

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
            configuration: .init(backgroundColor: .orange)) {
            Text("This notification uses a custom configuration")
                .padding()
        }
    }
}
```

To apply the context-based notification to a view, use the context-based `systemNotification` view modifier:

```swift
yourView
    .systemNotification(notification)
```

You can use the same context in your entire application, to ensure that your notifications are visible from different view hierarchies (e.g. tabs, modal sheets). Just create an observed instance in your application root and either pass it around or inject is into the view hierarchy as an environment object.  

Context-based notifications are very versatile and a great choice if you want to present many different notifications with a single modifier.



## iOS system notification

The standard iOS system notification has a special look, with a leading icon, a title and a message.

To mimic this notification, just use a ``SystemNotificationMessage``, which lets you specify an icon, title and message, as well as an optional, custom configuration.  

You present it just like you would any other view, with either a view- or context-based modifier:

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



## Configuration

The library gives you full controll over the look and behavior of your notifications. See ``SystemNotificationConfiguration`` and ``SystemNotificationMessageConfiguration`` for more information and have a look at the demo app for examples. 
