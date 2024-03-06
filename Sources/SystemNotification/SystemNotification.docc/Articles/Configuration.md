# Configuration

This article describes how you can configure a system notification.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}


## Overview

A system notification can be configured in a couple of ways. 

For instance, you can provide a ``SystemNotificationConfiguration`` to the view modifier:

```swift
struct MyView: View {

    @StateObject 
    private var notification = SystemNotificationContext()

    var body: some View {
        List {
            ...
        }
        .systemNotification(
            notification,
            configuration: .init(duration: 5)
        )
    }
}
```

This will be used as the default configuration and applied to all notifications.



## How to change the default configuration

If you don't provide a custom configuration, the ``SystemNotificationConfiguration/standard`` configuration will be used. You can change this value to a custom one to change the global default.



## How to configure a single notification

You can override the default configuration whenever you present a context-based notification:

```
notification.present(
    configuration: .init(duration: 10)
) {
    Text("An important notification that shows for a longer time")
}
```

This configuration is just used for this notification, after which it resets to the default one.
