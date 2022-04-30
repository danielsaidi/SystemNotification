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
 
 When you create a notification, you must provide it with an
 `isActive` binding, which controls if it's presented or not.
 You can also provide a `configuration` to customize how the
 notification looks and behaves.
 
 A system notification can present any custom view, but also
 has a convenience init in `SystemNotification+Message` that
 lets you show a standard `SystemNotificationMessage`.
 
 Use the `View+SystemNotification` view extensions to attach
 a system notification to a view using either a notification
 builder or a context. Make sure to attach it to the topmost
 view, e.g. a tab view or a navigation view, if any.
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
    
    @Environment(\.colorScheme) private var colorScheme
    
    public var body: some View {
        content(isActive)
            .background(background)
            .cornerRadius(cornerRadius)
            .bindSize(to: $contentSize)
            .shadow(
                color: configuration.shadowColor,
                radius: configuration.shadowRadius,
                y: configuration.shadowOffset)
            .padding(.horizontal)
            .animation(.spring())
            .offset(x: 0, y: verticalOffset)
            #if os(iOS) || os(macOS) || os(watchOS)
            .gesture(swipeGesture)
            #endif
    }
}


// MARK: - Private View Logic

private extension SystemNotification {
    
    @ViewBuilder
    var background: some View {
        if let color = configuration.backgroundColor {
            color
        } else {
            fallbackBackgroundColor
        }
    }
    
    var cornerRadius: CGFloat {
        configuration.cornerRadius ?? contentSize.height / 2
    }
    
    #if os(iOS) || os(macOS) || os(watchOS)
    var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .global)
            .onEnded { value in
                let horizontalTranslation = value.translation.width as CGFloat
                let verticalTranslation = value.translation.height as CGFloat
                let isVertical = abs(verticalTranslation) > abs(horizontalTranslation)
                let isUp = verticalTranslation < 0
                // let isLeft = horizontalTranslation < 0
                guard isVertical else { return }            // We only use vertical edges
                if isUp && configuration.edge == .top { dismiss() }
                if !isUp && configuration.edge == .bottom { dismiss() }
            }
    }
    #endif
    
    @ViewBuilder
    var fallbackBackgroundColor: some View {
        if colorScheme == .light {
            Color.primary.colorInvert()
        } else {
            #if os(iOS)
            Color(UIColor.secondarySystemBackground)
            #else
            Color.secondary.colorInvert()
            #endif
        }
    }
}


// MARK: - Private Logic

private extension SystemNotification {
    
    var verticalOffset: CGFloat {
        if isActive { return 0 }
        switch configuration.edge {
        case .top: return -200
        case .bottom: return 200
        }
    }
    
    func dismiss() {
        isActive = false
    }
}
