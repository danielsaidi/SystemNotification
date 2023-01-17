# Release notes

Deprecations will most often be removed in the next minor update.

If you have problem upgrading from a few minor versions back, try upgrading step-wise.


## 0.7

This version splits up `SystemNotificationConfiguration` in a configuration and style type.

Due to changes in the `SystemNotificationMessage` capabilities, the `LocalizedStringKey` support has been deprecated.

Also, since SystemNotification aims to be a pure SwiftUI project, the `SystemNotificationUIKitOverlay` has been deprecated. Please let me know if you really need it, and I'll re-add it to the library.

### ✨ New features

* `SystemNotificationMessage` now supports a custom icon view.
* `SystemNotificationStyle` is a new type that's extracted from `SystemNotificationConfiguration`.

### 💡 Behavior changes

* `SystemNotification` no longer uses async size bindings to apply the corner radius.

### 🗑 Deprecated

* `SystemNotificationConfiguration` moves all styles to `SystemNotificationStyle`.
* `SystemNotificationMessage` has deprecated its `LocalizedString` initializer.
* `SystemNotificationMessageConfiguration` is renamed to `SystemNotificationMessageStyle`.



## 0.6

### ✨ New features

* `SystemNotificationConfiguration` has a new `padding` parameter.
* `SystemNotificationConfiguration` has a new `standardBackgroundColor` function.
* `SystemNotificationConfiguration` has a new `standardPadding` property.

### 💡 Behavior changes

* `SystemNotificationContext` handles custom presentation configurations better.

### 💥 Breaking changes

* All deprecated code has been removed.



## 0.5.3

### 💡 Behavior changes

* `SystemNotificationContext` `present` now has an optional configuration.
* `SystemNotificationContext` now uses its own configuration if none is provided.



## 0.5.2

This release fixes compile errors on tvOS and watchOS.



## 0.5.1

This release makes configuration properties mutable.



## 0.5

This release greatly improves how notifications are presented and dismissed and simplifies usage.

The demo app now uses a local package, which makes it a lot easier to develop the library.

### 📖 Documentation

SystemNotification has a brand new DocC documentation.

Due to the new documentation, the package now requires Swift 5.5.

### ✨ New features

* `SystemNotificationContext` has a new completion-based dismiss function.
* `SystemNotificationMessageConfiguration` has new `iconTextSpacing` and `titleTextSpacing` properties.
* `SystemNotificationUIKitOverlay` is a new view that simplifies adding a system notification to a UIKit view.
* `View+SystemNotification` has a new parameter-based extension that replaces the old notification-based one.

### 💡 Behavior changes

* `SystemNotificationMessageConfiguration` is adjusted to make a message look more like an iPhone system notification.
* Presenting a new notification first dismisses the current notification, if any.
* The auto-dismiss logic is moved from the system notification to the notification context.   

### 🐛 Bug fixes

* This version fixes a bug, where the message configuration padding was incorrectly applied.

### 🗑 Deprecated

* The notification-based `systemNotification(:)` function is deprecated.

### 💥 Breaking changes

* `SystemNotification+Message` has been deprecated.
* `SystemNotificationConfiguration` `minWidth` is no longer used and has been removed.
* `View+SystemNotification` has deprecated the `SystemNotification`-based extension.



## 0.4.3

### ✨ New features 

* `SystemNotificationConfiguration` has a new `isSwipeToDismissEnabled` parameter.
* `SystemNotification` can now be swiped to be dismissed, if `isSwipeToDismissEnabled` is `true`. 



## 0.4.2

This relase makes it possible to provide a `nil` title to `SystemNotificationMessage`.



## 0.4.1

This relase makes it possible to use plain `String` values when creating `SystemNotification` and  `SystemNotificationMessage`.



## 0.4

### ✨ New features

* The context-based view modifier no longer requires a `context` parameter name.

### 🗑 Deprecated

* `systemNotification(context:)` is replaced with `systemNotification(_ context:)`.

### 🐛 Bug fixes

* This version fixes a bug, where the configuration duration wasn't applied.
* This version fixes a bug, where the default dark mode background was transparent.



## 0.3.2

### 🐛 Bug fixes

* This version fixes a preview bug that caused the library not to build for macOS. 



## 0.3.1

### ✨ New features

* Thanks to Christian Mitteldorf, system notifications now use localized string keys, which makes it super simple to create localized notifications.



## 0.3.0

This release has some breaking name changes and makes it easier to present multiple notifications with a single modifier.

### ✨ New features

* `SystemNotificationContext` makes it easy to present multiple notifications with a single modifier.

### 💥 Breaking changes

* `SystemNotification.Configuration` has been renamed to `SystemNotificationConfiguration`
* `SystemNotificationMessage.Configuration` has been renamed to `SystemNotificationMessageConfiguration`



## 0.2.0

This release improves platform supports, adds convenience utils and tweaks design. 

### ✨ New features

* The library now supports macOS, tvOS and watchOS as well.
* `SystemNotification.Configuration` has new shadow properties.

### 💡 Behavior changes

* The configuration types are no longed nested, to avoid generic limitations.

### 🎨 Design changes

* `SystemNotification.Configuration` has removed the background opacity modifier.
* `SystemNotification.Configuration` has now applies a more subtle standard shadow.
* `SystemNotificationMessage.Configuration` now uses `title3` as standard icon font.

### 🐛 Bug fixes

* The corner radius now works even when no image is provided. 



## 0.1.0

This is the first public release of SystemNotification. 

Check out the readme and the demo app for information about how to use it.
