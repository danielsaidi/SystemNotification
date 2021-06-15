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
            .padding(.horizontal)
            .animation(.spring())
            .offset(x: 0, y: verticalOffset)
            .onChange(of: isActive) { _ in resetTimer() }
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
        
        @StateObject private var context = SystemNotificationContext()
        
        
        func showCustomView() {
            context.present(
                content: SystemNotificationPreview.custom,
                configuration: SystemNotificationPreview.customConfig)
        }
        
        func showError() {
            context.present(
                content: SystemNotificationPreview.error,
                configuration: SystemNotificationPreview.errorConfig)
        }
        
        func showSilentModeOff() {
            context.present(
                content: SystemNotificationPreview.silentModeOff)
        }
        
        func showSilentModeOn() {
            context.present(
                content: SystemNotificationPreview.silentModeOn)
        }
        
        func showWarning() {
            context.present(
                content: SystemNotificationPreview.warning,
                configuration: SystemNotificationPreview.warningConfig)
        }
        
        func showStaticNotification() {
            isActive = true
        }
        
        var body: some View {
            NavigationView {
                List {
                    Section(header: Text("Context-based notifications").padding(.top)) {
                        Button("Show silent mode on", action: showSilentModeOn)
                        Button("Show silent mode off", action: showSilentModeOff)
                        Button("Show orange warning", action: showWarning)
                        Button("Show red error from bottom", action: showError)
                        Button("Show custom view", action: showCustomView)
                    }
                    Section(header: Text("Static notifications")) {
                        Button("Show static notification", action: showStaticNotification)
                    }
                }
                .navigationTitle("Test")
                .withListStyle()
                .withNavigationBarStyle()
            }
            .systemNotification(context: context)
            .systemNotification {
                SystemNotification(isActive: $isActive) { _ in
                    SystemNotificationPreview.silentModeOn
                }
            }
        }
    }
    
    static var previews: some View {
        Content()
    }
}

private extension View {
    
    func withListStyle() -> some View {
        #if os(iOS)
        self.listStyle(InsetGroupedListStyle())
        #else
        self
        #endif
    }
    
    func withNavigationBarStyle() -> some View {
        #if os(iOS)
        self.navigationBarTitleDisplayMode(.inline)
        #else
        self
        #endif
    }
}
