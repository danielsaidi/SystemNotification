import SwiftUI

public extension SystemNotificationConfiguration {

    @available(*, deprecated, message: "Use SystemNotificationStyle instead")
    static func standardBackgroundColor(for colorScheme: ColorScheme) -> some View {
        SystemNotificationStyle.standardBackgroundColor(for: colorScheme)
    }

    @available(*, deprecated, message: "Use SystemNotificationStyle instead")
    static var standardPadding: EdgeInsets {
        SystemNotificationStyle.standardPadding
    }
}

public extension SystemNotificationConfiguration {

    @available(*, deprecated, message: "Use SystemNotificationStyle for the styling instead")
    init(
        animation: Animation = .spring(),
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        padding: EdgeInsets? = nil,
        duration: TimeInterval = 3,
        edge: SystemNotificationEdge = .top,
        isSwipeToDismissEnabled: Bool = true,
        shadowColor: Color = .black.opacity(0.1),
        shadowOffset: CGFloat = 5,
        shadowRadius: CGFloat = 7.5
    ) {
        self.animation = animation
        self.duration = duration
        self.isSwipeToDismissEnabled = isSwipeToDismissEnabled
        self.style = SystemNotificationStyle(
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius,
            padding: padding,
            edge: edge,
            shadowColor: shadowColor,
            shadowOffset: shadowOffset,
            shadowRadius: shadowRadius
        )
    }

    @available(*, deprecated, message: "Use SystemNotificationStyle instead")
    var backgroundColor: Color? {
        get { style.backgroundColor }
        set { style.backgroundColor = newValue }
    }

    @available(*, deprecated, message: "Use SystemNotificationStyle instead")
    var cornerRadius: CGFloat? {
        get { style.cornerRadius }
        set { style.cornerRadius = newValue }
    }

    @available(*, deprecated, message: "Use SystemNotificationStyle instead")
    var edge: SystemNotificationEdge {
        get { style.edge }
        set { style.edge = newValue }
    }

    @available(*, deprecated, message: "Use SystemNotificationStyle instead")
    var padding: EdgeInsets {
        get { style.padding }
        set { style.padding = newValue }
    }

    @available(*, deprecated, message: "Use SystemNotificationStyle instead")
    var shadowColor: Color {
        get { style.shadowColor }
        set { style.shadowColor = newValue }
    }

    @available(*, deprecated, message: "Use SystemNotificationStyle instead")
    var shadowOffset: CGFloat {
        get { style.shadowOffset }
        set { style.shadowOffset = newValue }
    }

    @available(*, deprecated, message: "Use SystemNotificationStyle instead")
    var shadowRadius: CGFloat {
        get { style.shadowRadius }
        set { style.shadowRadius = newValue }
    }
}
