<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="SystemNotification Logo" title="SystemNotification" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/SystemNotification?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-5.6-orange.svg" alt="Swift 5.6" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/danielsaidi/SystemNotification" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" />
    </a>
    <a href="https://mastodon.social/@danielsaidi">
        <img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" />
    </a>
</p>



## About SystemNotification

SystemNotification can be used to present notifications that mimic the native iOS system notification that for instance are shown when you toggle silent mode on and off, connect your AirPods etc. 

The result can look like this, or completely different:

<p align="center">
    <img src="Resources/Demo.gif" width=350 />
</p>

System notifications can be styled and customized to great extent. You can also use completely custom views.

SystemNotification supports `iOS 14`, `macOS 11`, `tvOS 14` and `watchOS 7`.



## Installation

SystemNotification can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/SystemNotification.git
```

If you prefer to not have external dependencies, you can also just copy the source code into your app.



## Getting started

The [online documentation][Documentation] has a [getting started guide][Getting-Started] guide to help you get started with SystemNotification.

SystemNotification supports both state- and context-based notifications, where context-based ones give you the most flexibility:

```swift
struct ContentView: View {

    @StateObject 
    private var context = SystemNotificationContext()

    var body: some View {
        NavigationView {
            List {
                Button("Show notification", action: showNotification)
                Button("Show orange notification", action: showCustomNotification)
            }
        }
        .environmentObject(context)
        .systemNotification(context)
    }
    
    func showNotification() {
        notification.present {
            SystemNotificationMessage(
                icon: Image(systemName: "􀋚"),
                title: Text("Silent mode")
                text: Text("Off"),
                style: .init(iconColor: .red)
            )
        }
    }
    
    func showCustomNotification() {
        notification.present(
            configuration: .init(backgroundColor: .orange)
        ) {
            VStack {
                Text("Custom notification")
                    .font(.headline)
                Divider()
                Text("SystemNotification supports using any content views you like.")
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}
```

In the code above, we both apply a system notification, but also passes in the context as an environment object. This lets other views in the view hierarchy use it to present a notifications from the same root view.

For more information, please see the [online documentation][Documentation] and [getting started guide][Getting-Started].



## Documentation

The [online documentation][Documentation] has articles, code examples etc. that let you overview the various parts of the library.



## Demo Application

The demo app lets you explore the library on iOS and macOS. To try it out, just open and run the `Demo` project.



## Support this library

I manage my various open-source projects in my free time and am really thankful for any help I can get from the community. 

You can sponsor this project on [GitHub Sponsors][Sponsors] or get in touch for paid support.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [danielsaidi.com][Website]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]
* Twitter: [@danielsaidi][Twitter]
* E-mail: [daniel.saidi@gmail.com][Email]



## License

SystemNotification is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://www.danielsaidi.com
[Twitter]: https://www.twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/SystemNotification/documentation/systemnotification/
[Getting-Started]: https://danielsaidi.github.io/SystemNotification/documentation/systemnotification/getting-started
[License]: https://github.com/danielsaidi/DeckKit/blob/master/LICENSE
