import SwiftUI

@available(*, deprecated, renamed: "SystemNotificationMessageStyle")
public typealias SystemNotificationMessageConfiguration = SystemNotificationMessageStyle

public extension SystemNotificationMessage {

    @available(*, deprecated, message: "Use the string-based initializer instead")
    init(
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        configuration: SystemNotificationMessageConfiguration
    ) where IconView == EmptyView {
        self.icon = EmptyView()
        self.title = title
        self.text = text
        self.style = configuration
    }

    @available(*, deprecated, message: "Use the string-based initializer instead")
    init(
        icon: Image,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        configuration: SystemNotificationMessageConfiguration
    ) where IconView == Image {
        self.icon = icon
        self.title = title
        self.text = text
        self.style = configuration
    }

    @available(*, deprecated, message: "Use the style-based initializer instead")
    init(
        title: String? = nil,
        text: String,
        configuration: SystemNotificationMessageConfiguration
    ) where IconView == EmptyView {
        self.init(icon: EmptyView(), title: title, text: text, style: configuration)
    }

    @available(*, deprecated, message: "Use the style-based initializer instead")
    init(
        icon: Image,
        title: String? = nil,
        text: String,
        configuration: SystemNotificationMessageConfiguration
    ) where IconView == Image {
        self.init(icon: icon, title: title, text: text, style: configuration)
    }
}
