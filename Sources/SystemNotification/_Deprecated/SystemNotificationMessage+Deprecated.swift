import SwiftUI

@available(*, deprecated, renamed: "SystemNotificationMessageStyle")
public typealias SystemNotificationMessageConfiguration = SystemNotificationMessageStyle

public extension SystemNotificationMessage {

    @available(*, deprecated, message: "Use the style-based initializer instead")
    init(
        icon: Image? = nil,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        configuration: SystemNotificationMessageConfiguration
    ) {
        self.init(icon: icon, title: title, text: text, style: configuration)
    }

    @available(*, deprecated, message: "Use the style-based initializer instead")
    init(
        icon: Image? = nil,
        title: String? = nil,
        text: String,
        configuration: SystemNotificationMessageConfiguration
    ) {
        self.init(icon: icon, title: title, text: text, style: configuration)
    }
}
