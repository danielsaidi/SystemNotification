# Release notes

[SystemNotification](https://github.com/danielsaidi/SystemNotification) honors semantic versioning, with the following strategy:

* Deprecations can happen at any time.
* Deprecations are removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` updates, if the alternative is worse.

These release notes cover the current major version. See older versions for older release notes.



## 1.4

This version bumps the package to Swift 6.1 and the demo app to iOS 26.



## 1.3

This version fixed a Xcode 26 build error and changes the default animation to `.bouncy`.



## 1.2.1

This patch lets you provide a custom bundle to `SystemNotificatonMessage`.



## 1.2

This version renames the `master` branch to `main` and updates to Swift 6.



## 1.1.2

Thanks to @martindufort there's now an AppKit-specific overlay.

### ✨ New features

`SystemNotificationAppKitOverlay` is a new AppKit-specific overlay view.



## 1.1.1

This version adds support for strict concurrency.



## 1.1

This version adds predefined system notification messages and styles and makes it easier to present a message.

### ✨ New features

* `SystemNotificationContext` has a new `presentMessage` function.
* `SystemNotificationMessage` has new, predefined `error`, `success`, `warning` and `silentMode` messages.
* `SystemNotificationMessageStyle` has new, predefined `prominent`, `error`, `success` and `warning` styles.



## 1.0

This version bumps the deployment targets and moves styling and configuration to view modifiers.

### 🚨 Important Information

* All previous style- and config-based initializers have been removed.

### 📱 New Deployment Targets

* .iOS(.v15)
* .macOS(.v12)
* .tvOS(.v15)
* .watchOS(.v8)
* .visionOS(.v1)

### ✨ New features

* `SystemNotification` is more self-managed than before.
* `SystemNotificationConfiguration` can now be used as an environment value.
* `SystemNotificationStyle` now supports background materials.
* `SystemNotificationStyle` can now be used as an environment value.
* `SystemNotificationMessageStyle` can now be used as an environment value.
* `SystemNotificationMessageStyle` now supports specifying a foreground color.
* `SystemNotificationMessageStyle` now supports specifying a background color.
* `View` has new system notification-related style- and config view modifiers.

### 🐛 Bug fixes

* `SystemNotification` now correctly applies the configuration animation.
