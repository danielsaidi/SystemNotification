# ``SystemNotification``

SystemNotification is a `SwiftUI` library that lets you mimic the native iOS system notification, which for instance is presented when toggling silent mode on and off on your iPhone.



## Overview

![SystemNotification logo](Logo.png)

System notifications have a standard style, but can be customized to great extent to fit your specific needs.



## Installation

SystemNotification can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/SystemNotification.git
```

or with CocoaPods

```
pod SystemNotification
```

If you prefer to not have external dependencies, you can also just copy the source code into your app.



## Supported Platforms

SystemNotification supports `iOS 14`, `macOS 11`, `tvOS 14` and `watchOS 7`.



## About this documentation

The online documentation is currently iOS-specific. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.

Note that DocC currently omits extensions, which means that some extensions are missing. Future versions will aim to improve this.



## License

SystemNotification is available under the MIT license.



## Topics

### Articles

- <doc:Getting-Started>
- <doc:Configuration>
- <doc:Styling>

### Types

- ``SystemNotification/SystemNotification``
- ``SystemNotificationConfiguration``
- ``SystemNotificationContext``
- ``SystemNotificationEdge``
- ``SystemNotificationMessage``
- ``SystemNotificationMessageStyle``
- ``SystemNotificationStyle`` 
- ``SystemNotificationUIKitOverlay`` 
