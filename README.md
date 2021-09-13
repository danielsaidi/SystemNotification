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

`SystemNotification` is a `SwiftUI` library that lets you mimic the native iOS system notification, that for instance is presented when toggling silent mode on and off.

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

A `SystemNotification` view can be created with an `isActive` binding, an optional `configuration` and any content view.

For instance, this notification will present a plain `Text`:

```swift
let notification = SystemNotification(
    isActive: $isNotificationActive) { _ in
        Text("Something happened!")
    }
```

You can use the `SystemNotificationMessage` to get a notification that looks like a native system notification:

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

For a standard `SystemNotificationMessage`, you can also use this shorthand:

```swift
let notification = SystemNotification(
    icon: Image?,
    title: String,
    text: String,
    isActive: $isNotificationActive,
    configuration: SystemNotification.Configuration(edge: .bottom))
```

You can use any views and custom configurations, for instance a red color presented from the bottom:

```swift
let notification = SystemNotification(
    isActive: $isNotificationActive,
    configuration: .init(edge: .bottom)) { _ in
        Color.red.frame(height: 150)
    }
```

Once you have a `SystemNotification`, you can use the `systemNotification` modifier to attach it to any view: 

```swift
List(items) { item
   HStack { item.name }
}.systemNotification(notification)
```

You can now present the notification by setting `isNotificationActive` to `true`.


### SystemNotificationContext

Instead of using the above approach, it's much easier and more flexible to use a context. 

A `SystemNotificationContext` can be used to present many different notifications with a single modifier.

Just create a `@StateObject` in your presenting view, then use the context-specific view modifier to attach the notification to any view:

```swift
@StateObject private var context = SystemNotificationContext()

List(items) { item
   HStack { item.name }
}.systemNotification(context)
```

You can now present notifications buy using the context's various `present` function:

```swift
context.present(
    content: notificationView,
    configuration: .init(backgroundColor: .red))
```

You can use any view as well as any configuration.

I highly recommend the context approach for more complex use-cases.


## Important things to consider

Since this library is based on system notifications being attached to a view, you have to think about how to handle navigation views, sheets and full screen modals.

Here are some common things to consider:

* When using a `TabView`, it's best to attach a separate notification to each root view.
* When using a `NavigationView`, attach the notification to the navigation view and pass the context/state down the view hierarchy.
* When you present a modal sheet or cover, create a new notification and attach it to the root view.

For global notifications, you should register all contexts/states so that they can be referred.

For instance, if something happens in the app, all tab views should show the notification. Iterate over all created contexts and show the notification in all that exist.

    However, a sheet should take over the global responsibility. Make this the active one and switch back to the previous ones as the sheet is dismissed.

Have a look at the demo, which covers many of these cases.


## Configurations


### SystemNotification

A `SystemNotification` can be configured with a configuration that specifies:

* `animation`
* `backgroundColor`
* `cornerRadius`
* `duration`
* `edge`
* `minWidth`
* `shadowColor`
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

Feel free to reach out if you have questions or if you want to contribute to this project in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## Sponsor my work

You can support my work by becoming a [GitHub Sponsor][Sponsors].


## License

SystemNotification is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com
[Sponsors]: https://github.com/sponsors/danielsaidi
