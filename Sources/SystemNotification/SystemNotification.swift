//
//  SystemNotification.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view mimics the native iOS system notification that
/// for instance is shown when toggling silent mode.
/// 
/// This view will render a notification shape that contains
/// the provided content view.
///
/// You can apply ``SwiftUI/View/systemNotificationStyle(_:)``
/// to style this view with a custom style, and also apply a
/// ``SwiftUI/View/systemNotificationConfiguration(_:)`` for
/// when you need to customize its behavior.
///
/// Note that you shouldn't use the view directly but rather
/// use the ``SwiftUI/View/systemNotification(_:)`` modifier.
public struct SystemNotification<Content: View>: View {

    /// Create a system notification view.
    ///
    /// - Parameters:
    ///   - isActive: A binding that controls the active state of the notification.
    ///   - configuration: The notification configuration to use, by default ``SystemNotificationConfiguration/standard``.
    ///   - style: The notification style to use, by default ``SystemNotificationStyle/standard``.
    ///   - content: The view to present within the notification badge.
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
    
    @Environment(\.colorScheme)
    private var colorScheme
    
    public var body: some View {
        content(isActive)
            .background(background)
            .cornerRadius(style.cornerRadius ?? 1_000)
            .shadow(
                color: style.shadowColor,
                radius: style.shadowRadius,
                y: style.shadowOffset)
            #if os(visionOS)
            .animation(.spring(), value: isActive)
            #else
            .animation(.spring())
            #endif
            .offset(x: 0, y: verticalOffset)
            #if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
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
    
    #if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
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
        switch style.edge {
        case .top: return -250
        case .bottom: return 250
        }
    }
    
    func dismiss() {
        isActive = false
    }
}

#Preview {
    
    struct Preview: View {
        
        @State var isPresented = false
        
        var body: some View {
            ZStack {
                
                
                SystemNotification(
                    isActive: $isPresented,
                    configuration: .standard,
                    style: .standard
                ) { param in
                    Text("HELLO")
                        .padding()
                }
                .onTapGesture {
                    isPresented.toggle()
                }
            }
        }
    }
    
    return Preview()
}
