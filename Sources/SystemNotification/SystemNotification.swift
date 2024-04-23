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
/// the provided content view. You can use a custom view, or
/// use ``SystemNotificationMessage`` for an iOS native look.
///
/// The view will use the applied style and configuration to
/// style itself, then behave according to the configuration.
///
/// You can apply ``SwiftUI/View/systemNotificationStyle(_:)``
/// to customize the notification style, e.g. color. You can
/// apply ``SwiftUI/View/systemNotificationConfiguration(_:)``
/// to customize its behavior, e.g. the animation & duration.
public struct SystemNotification<Content: View>: View {
    
    /// Create a system notification view.
    ///
    /// - Parameters:
    ///   - isActive: A binding that controls the active state of the notification.
    ///   - content: The view to present within the notification badge.
    public init(
        isActive: Binding<Bool>,
        @ViewBuilder content: @escaping ContentBuilder
    ) {
        _isActive = isActive
        self.initStyle = nil
        self.initConfig = nil
        self.content = content
    }

    @available(*, deprecated, message: "Inject style and configuration with the new view modifiers instead.")
    public init(
        isActive: Binding<Bool>,
        configuration: SystemNotificationConfiguration = .standard,
        style: SystemNotificationStyle = .standard,
        @ViewBuilder content: @escaping ContentBuilder
    ) {
        _isActive = isActive
        self.initStyle = style
        self.initConfig = configuration
        self.content = content
    }
    
    public typealias ContentBuilder = (_ isActive: Bool) -> Content

    private let initConfig: SystemNotificationConfiguration?
    private let initStyle: SystemNotificationStyle?
    private let content: ContentBuilder
    
    @Binding
    private var isActive: Bool
    
    @Environment(\.colorScheme)
    private var colorScheme
    
    @Environment(\.systemNotificationConfiguration)
    private var envConfig
    
    @Environment(\.systemNotificationStyle)
    private var envStyle
    
    @State
    private var currentId = UUID()
    
    public var body: some View {
        ZStack(alignment: edge.alignment) {
            Color.clear
            content(isActive)
                .background(background)
                .cornerRadius(style.cornerRadius ?? 1_000)
                .shadow(
                    color: style.shadowColor,
                    radius: style.shadowRadius,
                    y: style.shadowOffset)
                .animation(config.animation, value: isActive)
                .offset(x: 0, y: verticalOffset)
                #if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
                .gesture(swipeGesture, if: config.isSwipeToDismissEnabled)
                #endif
                .padding(style.padding)
                .onChange(of: isActive, perform: handlePresentation)
        }
    }
}

private extension SystemNotification {
    
    var config: SystemNotificationConfiguration {
        initConfig ?? envConfig
    }

    var edge: SystemNotificationEdge {
        config.edge
    }
    
    var verticalOffset: CGFloat {
        if isActive { return 0 }
        switch edge {
        case .top: return -250
        case .bottom: return 250
        }
    }
    
    func dismiss() {
        isActive = false
    }
    
    var style: SystemNotificationStyle {
        initStyle ?? envStyle
    }
    
    func handlePresentation(_ isPresented: Bool) {
        guard isPresented else { return }
        currentId = UUID()
        let id = currentId
        DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
            if id == currentId {
                isActive = false
            }
        }
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
                if isUp && edge == .top { dismiss() }
                if !isUp && edge == .bottom { dismiss() }
            }
    }
    #endif
}

#Preview {
    
    struct Preview: View {
        
        @State var isPresented = false
        
        var body: some View {
            ZStack {
                AsyncImage(url: .init(string: "https://picsum.photos/200/300")) {
                
                    $0.image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .ignoresSafeArea()
                
                HStack {
                    SystemNotification(
                        isActive: $isPresented
                    ) { param in
                        Text("HELLO")
                            .padding()
                    }
                    .systemNotificationStyle(.standard)
                    .systemNotificationConfiguration(.standard)
                    
                    SystemNotification(
                        isActive: $isPresented
                    ) { param in
                        Text("HELLO")
                            .padding()
                    }
                    .systemNotificationStyle(
                        .init(backgroundColor: .red)
                    )
                    .systemNotificationConfiguration(
                        .init(animation: .bouncy)
                    )
                }
                
                
                SystemNotification(
                    isActive: $isPresented
                ) { param in
                    Text("HELLO")
                        .padding()
                }
                .systemNotificationConfiguration(
                    .init(
                        animation: .smooth,
                        edge: .bottom
                    )
                )
            }
            .onTapGesture {
                isPresented.toggle()
            }
        }
    }
    
    return Preview()
}
