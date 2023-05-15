# Styling

This article describes how you can style a system notification.



## Overview
A system notification can be styled in a couple of ways.

For instance, you can provide a default ``SystemNotificationStyle`` to the view modifier:

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

This will be used as the default style and applied to all notifications. 



## How to change the default style

If you don't provide a custom style, the ``SystemNotificationStyle/standard`` style will be used.

You can change this value to a custom one to change the global default.



## How to style a single notification

You can override the default style whenever you present a context-based notification:

```
notification.present(
    style: .init(backgroundColor: .green)
) {
    Text("A green message with white text")
        .foregroundColor(.white)
}
```

This style is just used for this notification, after which it resets to the default one.
