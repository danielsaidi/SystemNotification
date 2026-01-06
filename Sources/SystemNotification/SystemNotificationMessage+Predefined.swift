//
//  SystemNotificationMessage+Predefined.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2024-04-24.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension SystemNotificationMessageStyle {
    
    static var error: Self {
        prominent(backgroundColor: .red)
    }
    
    static var success: Self {
        prominent(backgroundColor: .green)
    }
    
    static var warning: Self {
        prominent(backgroundColor: .orange)
    }
    
    static func prominent(
        backgroundColor: Color
    ) -> Self {
        .init(
            backgroundColor: backgroundColor,
            iconColor: .white,
            textColor: .white.opacity(0.8),
            titleColor: .white
        )
    }
}

public extension SystemNotificationMessage where IconView == Image {
    
    static func error(
        icon: Image = .init(systemName: "exclamationmark.triangle"),
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        bundle: Bundle? = nil
    ) -> Self {
        .init(
            icon: icon,
            title: title,
            text: text,
            style: .error,
            bundle: bundle
        )
    }
    
    static func success(
        icon: Image = .init(systemName: "checkmark"),
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        bundle: Bundle? = nil
    ) -> Self {
        .init(
            icon: icon,
            title: title,
            text: text,
            style: .success,
            bundle: bundle
        )
    }
    
    static func warning(
        icon: Image = .init(systemName: "exclamationmark.triangle"),
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        bundle: Bundle? = nil
    ) -> Self {
        .init(
            icon: icon,
            title: title,
            text: text,
            style: .warning,
            bundle: bundle
        )
    }
}

public extension SystemNotificationMessage where IconView == AnyView {
    
    /// This message mimics a native iOS silent mode message.
    static func silentMode(
        isOn: Bool,
        title: LocalizedStringKey? = nil
    ) -> Self {
        .init(
            icon: AnyView(SilentModeBell(isSilentModeOn: isOn)),
            text: title ?? "Silent Mode \(isOn ? "On" : "Off")"
        )
    }
}

private struct SilentModeBell: View {

    var isSilentModeOn = false

    @State
    private var isRotated: Bool = false

    @State
    private var isAnimated: Bool = false

    var body: some View {
        Image(systemName: iconName)
            .rotationEffect(
                .degrees(isRotated ? -45 : 0),
                anchor: .top
            )
            .animation(
                .interpolatingSpring(
                    mass: 0.5,
                    stiffness: animationStiffness,
                    damping: animationDamping,
                    initialVelocity: 0
                ),
                value: isAnimated)
            .foregroundColor(iconColor)
            .onAppear(perform: animate)
    }
}

@MainActor
private extension SilentModeBell {

    func animate() {
        withAnimation { isRotated = true }
        perform(after: 0.1) {
            isRotated = false
            isAnimated = true
        }
    }

    func perform(after: Double, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            action()
        }
    }

    var animationDamping: Double {
        isSilentModeOn ? 4 : 1.5
    }

    var animationStiffness: Double {
        isSilentModeOn ? 129 : 179
    }

    var iconName: String {
        isSilentModeOn ? "bell.slash.fill" : "bell.fill"
    }

    var iconColor: Color {
        isSilentModeOn ? .red : .gray
    }
}

#Preview {
 
    VStack {
        SystemNotificationMessage.silentMode(isOn: true)
        SystemNotificationMessage.silentMode(isOn: false)
        SystemNotificationMessage.error(title: "Error!", text: "Something failed!")
        SystemNotificationMessage.success(title: "Success!", text: "You did it!")
        SystemNotificationMessage.warning(title: "Warning!", text: "Danger ahead!")
    }
    .padding()
    .background(Color.black.opacity(0.1))
    .clipShape(.rect(cornerRadius: 10))
}
