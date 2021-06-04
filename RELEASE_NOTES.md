# Release notes


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
