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

SystemNotification lets you present any SwiftUI view as iOS system notifications, which are the ones that appear from the top when you e.g. toggle Silent Mode or connect your AirPods.

System notifications are added just as you add a `sheet`, `alert` and `fullScreenModal`:

```swift
YourView()
    .systemNotification(...)
```

You can either add a view- or context-based system notification.

[Read more here][Getting-Started]



## Documentation

The SystemNotification documentation contains extensive information, code examples etc. and makes it easy to overview the various parts of the library.

You can either [download][Documentation] the documentation or build it directly in Xcode, using `Product/Build Documentation`.



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

SystemNotification is available under the MIT license. See the [LICENSE][License] file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://github.com/danielsaidi/Documentation/blob/main/Docs/KeyboardKit.doccarchive.zip?raw=true
[License]: https://github.com/danielsaidi/SystemNotification/blob/master/LICENSE

[Getting-Started]: https://github.com/danielsaidi/SystemNotification/blob/master/Readmes/Getting-Started.md
