//
//  SystemNotification.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the native iOS system notification that is
 presented when e.g. silent mode is toggled.
 
 To attach a system notification to a view hiearchy, use the
 `View+SystemNotification` view extension.
 
 When you create a notification, you must provide it with an
 `isActive` binding, which controls if it's presented or not.
 You can also provide a custom `configuration`, to customize
 the look and behavior of the notification.
 
 A notification can present any custom view, but also has an
 extra convenience initializer that lets you show a standard
 `SystemNotificationMessage` that mimics the native content.
 */
public struct SystemNotification<Content: View>: View {
    
    
    /// Create a system notification that uses a custom view.
    ///
    /// - Parameters:
    ///   - isActive: A binding that controls the active state of the notification.
    ///   - configuration: The notification configuration to use.
    ///   - content: The view to present within the notification badge.
    public init(
        isActive: Binding<Bool>,
        configuration: Configuration = Configuration(),
        @ViewBuilder content: @escaping ContentBuilder) {
        _isActive = isActive
        self.configuration = configuration
        self.content = content
    }
    
    public typealias ContentBuilder = (_ isActive: Bool) -> Content
    
    public let configuration: Configuration
    
    private let content: ContentBuilder
    
    @Binding private var isActive: Bool
    
    @State private var contentSize = CGSize.zero
    @State private var lastChanged = Date()
    
    @Environment(\.colorScheme) private var colorScheme
    
    public var body: some View {
        content(isActive)
            .background(background)
            .bindSize(to: $contentSize)
            .frame(minWidth: configuration.minWidth)
            .cornerRadius(configuration.cornerRadius ?? fallbackCornerRadius)
            .shadow(radius: configuration.shadowRadius)
            .animation(.spring())
            .offset(x: 0, y: verticalOffset)
            .onChange(of: isActive, perform: { _ in resetTimer() })
    }
}


// MARK: - Public Extensions

public extension SystemNotification where Content == SystemNotificationMessage {
    
    /// Create a notification that uses a standard `SystemNotificationMessage` content view.
    ///
    /// - Parameters:
    ///   - icon: The left-size icon.
    ///   - title: The bold title text.
    ///   - text: The plain message text.
    ///   - isActive: A binding that controls the active state of the notification.
    ///   - configuration: The notification configuration to use.
    init(
        icon: Image?,
        title: String,
        text: String,
        isActive: Binding<Bool>,
        configuration: Configuration = Configuration()) {
        self.init(
            isActive: isActive,
            configuration: configuration) { _ in
            SystemNotificationMessage(icon: icon, title: title, text: text)
        }
    }
}


// MARK: - Private Extensions

private extension SystemNotification {
    
    @ViewBuilder
    var background: some View {
        #if os(iOS) || os(tvOS)
        if configuration.useFrostEffectWhereApplicable {
            backgroundView.blur(.regular)
        } else {
            backgroundView
        }
        #else
        backgroundView
        #endif
    }
    
    @ViewBuilder
    var backgroundView: some View {
        if let color = configuration.backgroundColor {
            color
        } else {
            fallbackBackgroundColor.colorInvert()
        }
    }
    
    var fallbackBackgroundColor: Color {
        colorScheme == .light ? Color.primary : .secondary
    }
    
    var fallbackCornerRadius: CGFloat {
        contentSize.height / 2
    }
    
    var verticalOffset: CGFloat {
        if isActive { return 0 }
        switch configuration.edge {
        case .top: return -200
        case .bottom: return 200
        }
    }
    
    func resetTimer() {
        let date = Date()
        lastChanged = date
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            guard lastChanged == date else { return }
            self.isActive = false
        }
    }
}


// MARK: - Previews

struct SystemNotification_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            List {
                ForEach(0...100, id: \.self) {
                    Text("This is item #\($0), used to demo the blending")
                        .foregroundColor(.yellow)
                        .background(Color.blue)
                        .padding()
                        .background(Color.red)
                }
            }
            VStack(spacing: 20) {
                SystemNotification(
                    isActive: .constant(true),
                    configuration: SystemNotification.Configuration(
                        edge: .top)) { _ in
                    SystemNotificationMessage(
                        icon: Image(systemName: "bell.slash.fill"),
                        title: "Silent mode",
                        text: "On",
                        configuration: SystemNotificationMessage.Configuration(
                            iconColor: .red
                        )
                    )
                }
                SystemNotification(
                    isActive: .constant(true),
                    configuration: SystemNotification.Configuration(
                        backgroundColor: .orange,
                        edge: .bottom)) { _ in
                    SystemNotificationMessage(
                        icon: Image(systemName: "exclamationmark.triangle"),
                        title: "Warning",
                        text: "This is a long message to demonstrate multiline messages.",
                        configuration: SystemNotificationMessage.Configuration(
                            iconColor: .white,
                            iconFont: .headline,
                            textColor: .white,
                            titleColor: .white,
                            titleFont: .headline
                        )
                    )
                }
                SystemNotification(
                    isActive: .constant(true),
                    configuration: SystemNotification.Configuration(
                        backgroundColor: .blue)) { _ in
                    HStack {
                        Color.yellow
                        Text("Custom view")
                            .foregroundColor(.white)
                        Color.yellow
                    }.frame(height: 30)
                }
            }
        }
    }
}
