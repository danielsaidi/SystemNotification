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
        configuration: SystemNotificationConfiguration = .standard,
        @ViewBuilder content: @escaping ContentBuilder) {
        _isActive = isActive
        self.configuration = configuration
        self.content = content
    }
    
    public typealias ContentBuilder = (_ isActive: Bool) -> Content
    
    public let configuration: SystemNotificationConfiguration
    
    private let content: ContentBuilder
    
    @Binding private var isActive: Bool
    
    @State private var contentSize = CGSize.zero
    @State private var lastChanged = Date()
    
    @Environment(\.colorScheme) private var colorScheme
    
    public var body: some View {
        content(isActive)
            .background(background)
            .frame(minWidth: configuration.minWidth)
            .cornerRadius(cornerRadius)
            .bindSize(to: $contentSize)
            .shadow(
                color: configuration.shadowColor,
                radius: configuration.shadowRadius,
                y: configuration.shadowOffset)
            .animation(.spring())
            .offset(x: 0, y: verticalOffset)
            .onChange(of: isActive) { _ in resetTimer() }
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
        icon: Image = Image(""),
        title: String,
        text: String,
        isActive: Binding<Bool>,
        configuration: SystemNotificationConfiguration = .standard) {
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
        if let color = configuration.backgroundColor {
            color
        } else {
            fallbackBackgroundColor.colorInvert()
        }
    }
    
    var cornerRadius: CGFloat {
        configuration.cornerRadius ?? contentSize.height / 2
    }
    
    var fallbackBackgroundColor: Color {
        colorScheme == .light ? Color.primary : .secondary
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
    
    struct Content: View {
        
        @State private var isActive = false
        
        var body: some View {
            NavigationView {
                ZStack {
                    List {
                        ForEach(0...100, id: \.self) {
                            Text("Item #\($0) - tap to show notification")
                                .onTapGesture {
                                    isActive.toggle()
                                }
                        }
                    }
                    
                    VStack(spacing: 20) {
                        SystemNotification(
                            isActive: .constant(true),
                            configuration: .init(
                                edge: .top)) { _ in
                            SystemNotificationMessage(
                                icon: Image(systemName: "bell.slash.fill"),
                                title: "Silent mode",
                                text: "On",
                                configuration: .init(
                                    iconColor: .red
                                )
                            )
                        }
                        SystemNotification(
                            isActive: .constant(true),
                            configuration: .init(
                                backgroundColor: .orange,
                                edge: .bottom)) { _ in
                            SystemNotificationMessage(
                                icon: Image(systemName: "exclamationmark.triangle"),
                                title: "Warning",
                                text: "This is a long message to demonstrate multiline messages.",
                                configuration: .init(
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
                            configuration: .init(
                                backgroundColor: .blue)) { _ in
                            HStack {
                                Spacer()
                                Text("Custom view")
                                    .padding()
                                    .background(Color.yellow)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                                    .padding(10)
                                Spacer()
                            }
                        }
                    }
                }
                .navigationTitle("Test")
                .withNavigationBarStyle()
            }
            .systemNotification {
                SystemNotification(
                    icon: Image(systemName: "bell.fill"),
                    title: "Silent mode",
                    text: "Off",
                    isActive: $isActive)
            }
        }
    }
    
    static var previews: some View {
        Content()
    }
}

private extension View {
    
    func withNavigationBarStyle() -> some View {
        #if os(iOS)
        self.navigationBarTitleDisplayMode(.inline)
        #else
        self
        #endif
    }
}
