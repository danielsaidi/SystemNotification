# SystemNotification

<p align="center">
    <img src ="Resources/Logo.png" width=600 /><br />
    <img src="https://img.shields.io/github/v/release/danielsaidi/SystemNotification?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/cocoapods/p/SystemNotification.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" alt="Swift 5.3" />
    <img src="https://img.shields.io/github/license/danielsaidi/SystemNotification" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About SystemNotification

`SystemNotification` is lets you mimic the native iOS system notification (that is presented when e.g. toggling silent mode on and off) in your `SwiftUI` apps.

The result can look like this...or completely different:

<p align="center">
    <img src="Resources/Demo.gif" width=300 />
</p>

These notifications have a default style, but can be customized to fit your specific app.


## Installation

### Swift Package Manager

```
https://github.com/danielsaidi/SystemNotification.git
```

### CocoaPods

```
pod SystemNotification
```


## Getting started

`SystemNotification` contains a `SystemNotification` view, that can be created with an `isActive` binding, an optional `configuration` and any content view.

For instance, this notification will present a plain `Text`:

```swift
let notification = SystemNotification(
    isActive: $isNotificationActive) { _ in
        Text("Something happened!")
    }
```

If you want your message to look like a native system notification, you can use a `SystemNotificationMessage`:

```swift
let notification = SystemNotification(
    isActive: $isNotificationActive) { _ in
        SystemNotificationMessage(
            icon: Image(systemName: "exclamationmark.triangle"), 
            title: "Alert", 
            text: "Something happened!",
            configuration: .init(iconColor: .red))
    }
```

For standard messages, you can use this shorthand as well:

```swift
let notification = SystemNotification(
    icon: Image?,
    title: LocalizedStringKey,
    text: LocalizedStringKey,
    isActive: $isNotificationActive,
    configuration: SystemNotification.Configuration(edge: .bottom))
```

You can use any view you like in the notification, for instance a red color presented from the bottom:

```swift
let notification = SystemNotification(
    isActive: $isNotificationActive,
    configuration: .init(edge: .bottom)) { _ in
        Color.red.frame(height: 150)
    }
```

Once you have a notification, you can attach it to any view, using the `systemNotification` modifier: 

```swift
List(items) { item
   HStack { item.name }
}.systemNotification(notification)
```

You can now present the notification by setting `isNotificationActive` to `true`.


### SystemNotificationContext

While the above examples show how easy it is to add a notification to a view, it just supports a single view.

Instead of having a state and a modifier per notification, you can use a `SystemNotificationContext` to present many different notifications with a single modifier.

Just create a `@StateObject` in your presenting view, then use the context-specific view modifier:

```swift
@StateObject private var context = SystemNotificationContext()

List(items) { item
   HStack { item.name }
}.systemNotification(context)
```

You can now present notifications buy using the context's various `present` function:

```swift
context.present(
    content: notification,
    configuration: .init(backgroundColor: .red))
```

You can use any view as well as any configuration.

I highly recommend the context approach for more complex use-cases.


## Important things to consider

Since this library is based on system notifications being attached to a view, you have to think about how to handle navigation views, sheets and full screen modals.

Here are some common things to consider:

* When you are using a `NavigationView` attach the notification to the navigation view and pass the context an `isActive` down the view hierarchy.
* When you present a modal, you must create a new notification and attach it to the root view.

Have a look at the demo, which covers the various cases.


## Configurations


### SystemNotification

A `SystemNotification` can be configured with a configuration that specifies:

* `animation`
* `backgroundColor`
* `cornerRadius`
* `edge`
* `minWidth`
* `duration`
* `shadowRadius`
* `shadowOffset`
* `shadowRadius`

You can customize these properties to control how the notification looks and behaves. 

The default configuration makes the notification look and behave like the native one.


### SystemNotificationMessage

A `SystemNotificationMessage` view can be configured with a configuration that specifies:

* `iconColor`
* `iconFont`
* `padding`
* `textColor`
* `textFont`
* `titleColor`
* `titleFont`

You can customize these properties to control how the notification message looks. 

The default configuration makes the message look like the native one.


## Demo app

This repo contains a basic demo app that demonstrates how to use the bottom sheet.

Just open the `Demo` project and run the app.


## Contact me

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## License

SystemNotification is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com
