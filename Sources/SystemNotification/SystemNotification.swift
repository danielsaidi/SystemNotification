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
 
 Although this view can use any view as its content, you can
 use the ``SystemNotificationMessage`` view to mimic the iOS
 notification, which has an `icon`, a `title` and a `text`.
 
 Use the `View+SystemNotification` view extensions to attach
 a system notification to a view.
 */
public struct SystemNotification<Content: View>: View {

    /**
     Create a system notification.

     - Parameters:
       - isActive: A binding that controls the active state of the notification.
       - configuration: The notification configuration to use, by default ``SystemNotificationConfiguration/standard``.
       - style: The notification style to use, by default ``SystemNotificationStyle/standard``.
       - content: The view to present within the notification badge.
     */
    public init(
        isActive: Binding<Bool>,
        configuration: SystemNotificationConfiguration = .standard,
        style: SystemNotificationStyle = .standard,
        @ViewBuilder content: @escaping ContentBuilder
    ) {
        _isActive = isActive
        self.style = style
        self.configuration = configuration
        self.content = content
    }
    
    public typealias ContentBuilder = (_ isActive: Bool) -> Content

    private let configuration: SystemNotificationConfiguration

    private let style: SystemNotificationStyle
    
    private let content: ContentBuilder
    
    @Binding
    private var isActive: Bool
    
    @State
    private var contentSize = CGSize.zero
    
    @Environment(\.colorScheme)
    private var colorScheme
    
    public var body: some View {
        content(isActive)
            .background(background)
            .cornerRadius(cornerRadius)
            .shadow(
                color: style.shadowColor,
                radius: style.shadowRadius,
                y: style.shadowOffset)
            .animation(.spring())
            .offset(x: 0, y: verticalOffset)
            .bindSize(to: $contentSize)
            #if os(iOS) || os(macOS) || os(watchOS)
            .gesture(swipeGesture, if: configuration.isSwipeToDismissEnabled)
            #endif
            .padding(style.padding)
    }
}


// MARK: - Private View Logic

private extension View {

    @ViewBuilder
    func gesture<GestureType: Gesture>(
        _ gesture: GestureType,
        if condition: Bool
    ) -> some View {
        if condition {
            self.gesture(gesture)
        } else {
            self
        }
    }
}

private extension SystemNotification {
    
    @ViewBuilder
    var background: some View {
        if let color = style.backgroundColor {
            color
        } else {
            SystemNotificationStyle.standardBackgroundColor(for: colorScheme)
        }
    }
    
    var cornerRadius: CGFloat {
        style.cornerRadius ?? contentSize.height / 2
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
                if isUp && style.edge == .top { dismiss() }
                if !isUp && style.edge == .bottom { dismiss() }
            }
    }
    #endif
}


// MARK: - Private Logic

private extension SystemNotification {
    
    var verticalOffset: CGFloat {
        if isActive { return 0 }
        let offset = max(contentSize.height, 250)
        switch style.edge {
        case .top: return -offset
        case .bottom: return offset
        }
    }
    
    func dismiss() {
        isActive = false
    }
}
